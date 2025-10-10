import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PreviewTemp extends StatefulWidget {
  final String path;
  const PreviewTemp({super.key, required this.path});

  @override
  State<PreviewTemp> createState() => _PreviewTempState();
}

class _PreviewTempState extends State<PreviewTemp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.file(
      File(widget.path),
    )..initialize().then((_) {
      setState(() {}); // Refresh to show the player
      _controller.play(); // Optional: auto-play
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preview Video")),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
          });
        },
        child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
