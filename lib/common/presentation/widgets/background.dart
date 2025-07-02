import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/core/app/app.dart';
import 'package:video_player/video_player.dart';

class Background extends StatefulWidget {
  final ThemeBackgroundEntity? entity;
  final bool? mute;
  final bool? isPreview;
  final double? width;
  final double? height;

  const Background({
    super.key,
    this.entity,
    this.mute,
    this.isPreview,
    this.width,
    this.height,
  });

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  VideoPlayerController? _backgroundVideoController;
  String? _path;
  bool? _isLiveBackground;
  Color? _color;
  bool? _isNetwork;
  bool? _isLocallyStored;
  String? _previewImage;

  @override
  void initState() {
    super.initState();
    _initializeBackground();
  }

  void _initializeBackground() {
    if (widget.entity != null) {
      _path = widget.entity!.path;
      _isLiveBackground = widget.entity!.isLiveBackground;
      _color = widget.entity!.solidColor;
      _isNetwork = widget.entity!.isNetwork;
      _isLocallyStored = widget.entity!.isLocallyStored;
      _previewImage = widget.entity!.previewImage;
    } else {
      _path = App.themeEntity.backgroundEntity.path;
      _isLiveBackground = App.themeEntity.backgroundEntity.isLiveBackground;
      _color = App.themeEntity.backgroundEntity.solidColor;
      _isNetwork = App.themeEntity.backgroundEntity.isNetwork;
      _isLocallyStored = App.themeEntity.backgroundEntity.isLocallyStored;
    }

    if ((_isLiveBackground ?? false) && _path != null) {
      _initializeVideoController();
    }
  }

  void _initializeVideoController() {
    _backgroundVideoController = VideoPlayerController.asset(_path!)
      ..initialize().then((_) {
        if (context.mounted) {
          setState(() {
            _backgroundVideoController!.play();
            if (widget.mute ?? false) {
              _backgroundVideoController!.setVolume(0);
            }
            _backgroundVideoController!.setLooping(true);
          });
        }
      });
  }

  @override
  void didUpdateWidget(covariant Background oldWidget) {
    if (oldWidget.entity != widget.entity) {
      _initializeBackground();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _backgroundVideoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth =
        widget.width ?? MediaQuery.of(context).size.width;
    final double screenHeight =
        widget.height ?? MediaQuery.of(context).size.height;

    if (_color != null) {
      return Container(width: screenWidth, height: screenHeight, color: _color);
    }
    if ((widget.isPreview ?? false) && _previewImage != null) {
      return CachedNetworkImage(
        imageUrl: _previewImage!,
        fit: BoxFit.cover,
        width: screenWidth,
        height: screenHeight,
      );
    }

    if (_isLocallyStored ?? false) {
      return Image.file(
        File(_path!),
        fit: BoxFit.cover,
        width: screenWidth,
        height: screenHeight,
      );
    }

    if (_isLiveBackground ?? false) {
      return SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: VideoPlayer(_backgroundVideoController!),
      );
    }

    return (_isNetwork ?? false)
        ? Image.network(
          _path!,
          fit: BoxFit.cover,
          width: screenWidth,
          height: screenHeight,
        )
        : Image.asset(
          _path!,
          fit: BoxFit.cover,
          width: screenWidth,
          height: screenHeight,
        );
  }
}
