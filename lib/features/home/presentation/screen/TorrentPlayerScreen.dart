import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go_torrent_streamer/flutter_go_torrent_streamer.dart';
import 'package:movies_app/core/resources/StringsManager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/resources/ColorsManager.dart';

class TorrentPlayerScreen extends StatefulWidget {
  final String magnetLink;
  final String title;

  const TorrentPlayerScreen({
    super.key,
    required this.magnetLink,
    required this.title,
  });

  @override
  State<TorrentPlayerScreen> createState() => _TorrentPlayerScreenState();
}

class _TorrentPlayerScreenState extends State<TorrentPlayerScreen> {
  final _streamer = FlutterTorrentStreamer();

  TorrentStreamSession? _session;
  VideoPlayerController? _videoController;

  bool _isBuffering = true;
  String _statusText = StringsManager.startingtorrent.tr();
  double _progress = 0;
  Timer? _pollTimer;

  @override
  void initState() {
    super.initState();
    _startStreaming();
  }

  Future<void> _startStreaming() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final savePath = '${dir.path}/torrents';
      await Directory(savePath).create(recursive: true);

      final session =
          await _streamer.startStream(widget.magnetLink, savePath);
      _session = session;

      _pollTimer = Timer.periodic(const Duration(seconds: 2), (_) async {
        await _checkStatus();
      });
    } catch (e) {
      if (mounted) {
        setState(() => _statusText = 'Error: $e');
      }
    }
  }

  Future<void> _checkStatus() async {
    if (_session == null) return;
    final status = await _session!.getStatus();
    final state = status['state'] as String? ?? '';
    final progress = (status['progress'] as num?)?.toDouble() ?? 0;
    final url = status['url'] as String? ?? _session!.streamUrl;

    if (mounted) {
      setState(() {
        _progress = progress;
        _statusText =
            '$state — ${progress.toStringAsFixed(1)}%';
      });
    }

    if (state != 'Metadata' && state != 'Stalled' && url.isNotEmpty &&
        _videoController == null) {
      _pollTimer?.cancel();
      await _initPlayer(url);
    }
  }

  Future<void> _initPlayer(String url) async {
    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    await controller.initialize();
    controller.play();
    if (mounted) {
      setState(() {
        _videoController = controller;
        _isBuffering = false;
      });
    }
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _videoController?.dispose();
    _session?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: _isBuffering ? _buildBuffering() : _buildPlayer(),
    );
  }

  Widget _buildBuffering() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
              color: ColorsManager.onPrimaryColor),
          const SizedBox(height: 24),
          Text(
            _statusText,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          if (_progress > 0) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: LinearProgressIndicator(
                value: _progress / 100,
                color: ColorsManager.onPrimaryColor,
                backgroundColor: Colors.white24,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlayer() {
    final controller = _videoController!;
    return Column(
      children: [
        Expanded(
          child: Center(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
        ),
        _VideoControls(controller: controller),
      ],
    );
  }
}

class _VideoControls extends StatefulWidget {
  final VideoPlayerController controller;
  const _VideoControls({required this.controller});

  @override
  State<_VideoControls> createState() => _VideoControlsState();
}

class _VideoControlsState extends State<_VideoControls> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_update);
  }

  void _update() => setState(() {});

  @override
  void dispose() {
    widget.controller.removeListener(_update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = widget.controller;
    final position = ctrl.value.position;
    final duration = ctrl.value.duration;

    return Container(
      color: Colors.black87,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VideoProgressIndicator(
            ctrl,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              playedColor: ColorsManager.onPrimaryColor,
              bufferedColor: Colors.white30,
              backgroundColor: Colors.white12,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_format(position),
                  style: const TextStyle(color: Colors.white70, fontSize: 12)),
              IconButton(
                icon: Icon(
                  ctrl.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () =>
                    ctrl.value.isPlaying ? ctrl.pause() : ctrl.play(),
              ),
              Text(_format(duration),
                  style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  String _format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }
}
