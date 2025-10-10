import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/core/libraries/direct_social_share/direct_social_share.dart';
import 'package:sureline/core/libraries/video_editor/video_editor.dart';
import 'package:sureline/features/share/data/model/render_model.dart';
import 'package:sureline/features/share/data/model/render_result_model.dart';
import 'package:sureline/features/share/data/model/share_model.dart';

abstract class ShareDataSource {
  Future<Either<Failure, void>> shareOnSocial(ShareModel model);

  Future<Either<Failure, void>> shareOnMessages(ShareModel model);

  Future<Either<Failure, void>> shareOnDefault(ShareModel model);

  Future<Either<Failure, void>> saveFile(String path);

  Future<Either<Failure, void>> startRenderingVideoPost(RenderModel model);

  Future<Either<Failure, String>> startRenderingImagePost(RenderModel model);

  Stream<RenderResultModel> renderResultStream();

  void disposeStream();
}

class ShareDataSourceImpl extends ShareDataSource {
  final _renderController = StreamController<RenderResultModel>.broadcast();

  ShareDataSourceImpl();

  @override
  Stream<RenderResultModel> renderResultStream() {
    VideoEditor.addListener((progress, url) {
      debugPrint('url from data source is this $url');
      final result = RenderResultModel(progress: progress, url: url);
      _renderController.add(result);
    });
    return _renderController.stream;
  }

  @override
  Future<Either<Failure, void>> shareOnSocial(ShareModel model) async {
    try {
      DirectSocialShare.share(
        videoPath: model.path!,
        schema: model.schema,
        appID: '2075312276312408',
        isImage: !model.renderEntity.isLiveBackground,
      );
      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> shareOnMessages(ShareModel model) async {
    try {
      DirectSocialShare.shareMessage(model.path!);
      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> startRenderingVideoPost(
    RenderModel model,
  ) async {
    try {
      final videoPath = await _copyAssetToFileAndGetPath(model.path);
      final textImagePath = await _convertTextToImage(model.quoteKey);
      VideoEditor.renderOverlayOnVideo(videoPath, textImagePath);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
    return Right(unit);
  }

  @override
  Future<Either<Failure, String>> startRenderingImagePost(
    RenderModel model,
  ) async {
    debugPrint('started rendering image post');
    try {
      final imagePath = await _convertTextToImage(model.rootKey);
      // final XFile? file = await ImagePicker().pickVideo(source: ImageSource.gallery);
      return Right(imagePath);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> saveFile(String path) async {
    try {
      if (path.endsWith('.mp4') || path.endsWith('.mov')) {
        final result = await GallerySaver.saveVideo(path);
      } else if (path.endsWith('.jpg') || path.endsWith('.png')) {
        await GallerySaver.saveImage(path);
      } else {
        debugPrint('Unsupported file type');
      }
      return Right(unit);
    } catch (e) {
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> shareOnDefault(ShareModel model) async {
    try {
      debugPrint('sharing on default');
      final XFile file = XFile(model.path!);
      await SharePlus.instance.share(
        ShareParams(files: [file], previewThumbnail: file),
      );
      return Right(unit);
    } catch (e) {
      debugPrint('${e}');
      return Left(UnknownFailure());
    }
  }

  @override
  void disposeStream() {
    _renderController.close();
  }

  Future<String> _copyAssetToFileAndGetPath(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);

    final tempDir = await getTemporaryDirectory();
    final fileName = assetPath.split('/').last;
    final file = File('${tempDir.path}/$fileName');

    await file.writeAsBytes(byteData.buffer.asUint8List(), flush: true);
    return file.path;
  }

  Future<String> _convertTextToImage(GlobalKey key) async {
    try {
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 6.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      final path = saveImageAndGetPath(
        byteData!.buffer.asUint8List(),
        '${DateTime.now().toIso8601String()}.png',
      );
      return path;
    } catch (e) {
      debugPrint('Error converting text to image: $e');
      return '';
    }
  }

  Future<String> saveImageAndGetPath(
    Uint8List imageBytes,
    String fileName,
  ) async {
    // Get the documents directory on iOS
    final Directory directory = await getTemporaryDirectory();

    // Create a complete path (e.g., /path/to/documents/your_file.png)
    final String filePath = '${directory.path}/$fileName';

    // Write the file
    final File file = File(filePath);
    await file.writeAsBytes(imageBytes);

    // Return the path
    return filePath;
  }
}
