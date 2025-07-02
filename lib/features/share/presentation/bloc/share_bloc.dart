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

class ShareBloc extends Bloc<ShareEvent, ShareState> {
  final RenderVideoPostUseCase _renderPostUseCase;
  final GetRenderResultsStreamUseCase _getRenderResultsStreamUseCase;
  final ShareOnSocialUseCase _shareOnSocialUseCase;
  final ShareOnMessageUseCase _shareOnMessageUseCase;
  final ShareOnDefaultUseCase _shareOnDefaultUseCase;
  final SavePostUseCase _savePostUseCase;
  final RenderImagePostUseCase _renderImagePostUseCase;
  final DisposeStreamUseCase _disposeStreamUseCase;

  ShareBloc(
    this._renderPostUseCase,
    this._getRenderResultsStreamUseCase,
    this._savePostUseCase,
    this._shareOnSocialUseCase,
    this._shareOnMessageUseCase,
    this._shareOnDefaultUseCase,
    this._renderImagePostUseCase,
    this._disposeStreamUseCase,
  ) : super(Initial()) {
    on<OpenInstagram>((event, emit) async {
      _renderPost(event, (url) {
        print('ig post is rendered');
        DirectSocialShare.shareOnInstagram(
          url,
          !event.entity.renderEntity.isLiveBackground,
        );
      });
    });

    on<OpenFacebook>((event, emit) async {
      _renderPost(event, (url) {
        DirectSocialShare.shareOnFacebook(videoPath: url);
      });
    });

    on<OpenTikTok>((event, emit) async {
      _renderPost(event, (url) async {
        DirectSocialShare.shareOnTikTok(
          path: url,
          isImage: !event.entity.renderEntity.isLiveBackground,
        );
      });
    });

    on<ShareOnSocial>((event, emit) {
      _renderPost(event, (url) async {
        await _shareOnSocialUseCase.execute(
          // Make input and output entities
          ShareEntity(
            schema: event.entity.schema,
            path: url,
            renderEntity: event.entity.renderEntity,
          ),
        );
      });
    });

    on<RenderResultReceived>((event, emit) {
      emit(Rendering(event.result.progress));
    });

    on<RenderCompleted>((event, emit) {
      emit(Rendered(event.proceed));
    });

    on<OpenMessages>((event, emit) {
      _renderPost(event, (url) async {
        await _shareOnMessageUseCase.execute(
          // Make input and output entities
          ShareEntity(
            schema: event.entity.schema,
            path: url,
            renderEntity: event.entity.renderEntity,
          ),
        );
      });
    });

    on<OpenDefaultShare>((event, emit) {
      _renderPost(event, (url) async {
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

    on<SavePost>((event, emit) {
      _renderPost(event, (url) async {
        await _savePostUseCase.execute(url);
      });
    });

    on<RenderingInProgress>((event, emit) {
      emit(Rendering(null));
    });
  }

  Future<File> _moveXFileToShareableDir(XFile xfile) async {
    final tempDir =
        await getTemporaryDirectory(); // or getApplicationDocumentsDirectory()
    final newPath = path.join(tempDir.path, path.basename(xfile.path));
    final file = await File(xfile.path).copy(newPath);
    final latestPath = path.join(tempDir.path, 'sureline_share.ig');
    return await File(file.path).copy(latestPath);
  }

  void _renderPost(event, Function(String) onComplete) async {
    if (((event.entity) as ShareEntity).renderEntity.isLiveBackground) {
      await _renderPostUseCase.execute(event.entity.renderEntity);
      final stream = _getRenderResultsStreamUseCase.execute();
      StreamSubscription? subscription;
      subscription = stream.listen((result) async {
        debugPrint('url is this ${result.url}');
        if (result.url.isEmpty) {
          add(RenderResultReceived(result));
        } else {
          add(RenderCompleted(proceed: onComplete(result.url)));
          await subscription?.cancel();
          _disposeStreamUseCase.execute();
        }
      });
    } else {
      add(RenderingInProgress());
      final result = await _renderImagePostUseCase.execute(
        (event.entity as ShareEntity).renderEntity,
      );

      result.fold(
        (left) {
          debugPrint('${left}');
        },
        (right) {
          debugPrint(right);
          add(RenderCompleted(proceed: () => onComplete(right)));
        },
      );
    }
  }
}
