import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:sureline/core/libraries/direct_social_share/direct_social_share.dart';
import 'package:sureline/core/libraries/direct_social_share/direct_social_share_schemas.dart';
import 'package:sureline/features/share/data/data_source/share_data_source.dart';
import 'package:sureline/features/share/domain/entity/render_result_entity.dart';
import 'package:sureline/features/share/domain/entity/share_entity.dart';
import 'package:sureline/features/share/domain/use_cases/dispose_stream_use_case.dart';
import 'package:sureline/features/share/domain/use_cases/get_render_results_stream_use_case.dart';
import 'package:sureline/features/share/domain/use_cases/render_image_post_use_case.dart';
import 'package:sureline/features/share/domain/use_cases/render_video_post_use_case.dart';
import 'package:sureline/features/share/domain/use_cases/save_post_use_case.dart';
import 'package:sureline/features/share/domain/use_cases/share_on_default_use_case.dart';
import 'package:sureline/features/share/domain/use_cases/share_on_message_use_case.dart';
import 'package:sureline/features/share/domain/use_cases/share_on_social_use_case.dart';
import 'package:sureline/features/share/presentation/bloc/share_event.dart';
import 'package:sureline/features/share/presentation/bloc/share_state.dart';

/// Bloc for managing social media sharing functionality and content rendering.
class ShareBloc extends Bloc<ShareEvent, ShareState> {
  /// Use case for rendering video posts with animations.
  final RenderVideoPostUseCase _renderPostUseCase;

  /// Use case for retrieving rendering progress stream.
  final GetRenderResultsStreamUseCase _getRenderResultsStreamUseCase;

  /// Use case for sharing content on social media platforms.
  final ShareOnSocialUseCase _shareOnSocialUseCase;

  /// Use case for sharing content via messages.
  final ShareOnMessageUseCase _shareOnMessageUseCase;

  /// Use case for sharing content via default share sheet.
  final ShareOnDefaultUseCase _shareOnDefaultUseCase;

  /// Use case for saving rendered content to device.
  final SavePostUseCase _savePostUseCase;

  /// Use case for rendering image posts.
  final RenderImagePostUseCase _renderImagePostUseCase;

  /// Use case for disposing rendering streams.
  final DisposeStreamUseCase _disposeStreamUseCase;

  /// Creates a new ShareBloc instance with all required use cases.
  ShareBloc(
    this._renderPostUseCase,
    this._getRenderResultsStreamUseCase,
    this._savePostUseCase,
    this._shareOnSocialUseCase,
    this._shareOnMessageUseCase,
    this._shareOnDefaultUseCase,
    this._renderImagePostUseCase,
    this._disposeStreamUseCase,
  ) : super(const Initial()) {
    // Instagram sharing with video/image support
    on<OpenInstagram>((event, emit) async {
      debugPrint('ig post is rendering');
      await _renderPost(event, emit, (url) {
        print('ig post is rendered');
        DirectSocialShare.shareOnInstagram(url, !event.entity.renderEntity.isLiveBackground);
      });
      debugPrint('finished');
    });

    // Facebook sharing with video support
    on<OpenFacebook>((event, emit) async {
      await _renderPost(event, emit, (url) {
        DirectSocialShare.shareOnFacebook(videoPath: url);
      });
    });

    // TikTok sharing with video/image support
    on<OpenTikTok>((event, emit) async {
      await _renderPost(event, emit, (url) async {
        DirectSocialShare.shareOnTikTok(
          path: url,
          isImage: !event.entity.renderEntity.isLiveBackground,
        );
      });
    });

    // Generic social media sharing
    on<ShareOnSocial>((event, emit) async {
      await _renderPost(event, emit, (url) async {
        await _shareOnSocialUseCase.execute(
          // Create share entity with rendered content
          ShareEntity(
            schema: event.entity.schema,
            path: url,
            renderEntity: event.entity.renderEntity,
          ),
        );
      });
    });

    // Handle rendering progress updates
    on<RenderResultReceived>((event, emit) {
      emit(Rendering(event.result.progress));
    });

    // Handle rendering completion
    on<RenderCompleted>((event, emit) {
      emit(Rendered(event.proceed));
    });

    // Messages sharing integration
    on<OpenMessages>((event, emit) async {
      await _renderPost(event, emit, (url) async {
        await _shareOnMessageUseCase.execute(
          // Create share entity for messages
          ShareEntity(
            schema: event.entity.schema,
            path: url,
            renderEntity: event.entity.renderEntity,
          ),
        );
      });
    });

    // Default share sheet integration
    on<OpenDefaultShare>((event, emit) async {
      await _renderPost(event, emit, (url) async {
        debugPrint('callback is executing');
        await _shareOnDefaultUseCase.execute(
          ShareEntity(
            schema: event.entity.schema,
            renderEntity: event.entity.renderEntity,
            path: url,
          ),
        );
      });
    });

    // Save rendered content to device
    on<SavePost>((event, emit) async {
      await _renderPost(event, emit, (url) async {
        await _savePostUseCase.execute(url);
      });
    });

    // Handle rendering in progress state
    on<RenderingInProgress>((event, emit) async {
      emit(Rendering(null));
    });
  }

  /// Moves XFile to a shareable directory for social media platforms.
  ///
  /// This method ensures that files are in the correct location and format
  /// for sharing on various social media platforms. It creates a temporary
  /// copy with the appropriate filename and extension.
  ///
  /// Parameters:
  /// - [xfile] The XFile to be moved and prepared for sharing
  ///
  /// Returns:
  /// - [Future<File>] The prepared file ready for sharing
  Future<File> _moveXFileToShareableDir(XFile xfile) async {
    final tempDir = await getTemporaryDirectory(); // or getApplicationDocumentsDirectory()
    final newPath = path.join(tempDir.path, path.basename(xfile.path));
    final file = await File(xfile.path).copy(newPath);
    final latestPath = path.join(tempDir.path, 'sureline_share.ig');
    return await File(file.path).copy(latestPath);
  }

  /// Renders content and executes sharing callback upon completion.
  ///
  /// This method coordinates the rendering process for both image and video
  /// content. It handles live background rendering with progress tracking
  /// and static image rendering for immediate sharing.
  ///
  /// Parameters:
  /// - [event] The share event containing render entity and schema
  /// - [onComplete] Callback function to execute when rendering is complete
  Future<void> _renderPost(
    ShareEvent event,
    Emitter<ShareState> emit,
    void Function(String) onComplete,
  ) async {
    // Ensure event.entity is a ShareEntity
    if (!((event as dynamic).entity is ShareEntity)) {
      throw ArgumentError('event.entity must be a ShareEntity');
    }
    final ShareEntity shareEntity = (event as dynamic).entity as ShareEntity;

    if (shareEntity.renderEntity.isLiveBackground) {
      // Handle live background rendering with progress tracking
      await _renderPostUseCase.execute(shareEntity.renderEntity);
      final stream = _getRenderResultsStreamUseCase.execute();
      StreamSubscription? subscription;

      subscription = stream.listen((result) async {
        debugPrint('url is this ${result.url}');
        if (result.url.isEmpty) {
          // Still rendering, update progress
          add(RenderResultReceived(result));
        } else {
          // Rendering complete, execute callback
          onComplete(result.url);
          add(RenderCompleted(proceed: () {}));
          await subscription?.cancel();
          _disposeStreamUseCase.execute();
        }
      });
    } else {
      // Handle static image rendering
      add(RenderingInProgress());
      final result = await _renderImagePostUseCase.execute(shareEntity.renderEntity);

      result.fold(
        (left) {
          debugPrint('${left}');
        },
        (right) {
          debugPrint(right);
          emit(
            Rendered(() {
              onComplete(right);
            }),
          );
        },
      );
    }
  }
}
