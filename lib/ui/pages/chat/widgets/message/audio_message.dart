import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/models/entities/chat/chat_message_entity.dart';
import 'package:flutter_base/models/entities/chat/chat_user_entity.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../models/entities/user/my_user_entity.dart';

class AudioMessage extends StatefulWidget {
  final ChatMessageEntity message;
  final MyUserEntity currentUser;

  const AudioMessage({
    Key? key,
    required this.message,
    required this.currentUser,
  }) : super(key: key);

  @override
  State<AudioMessage> createState() => _AudioMessageState();
}

class _AudioMessageState extends State<AudioMessage> {
  late AudioPlayerManager manager;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    manager = AudioPlayerManager(url: widget.message.meta?["url"] ?? "");
    manager.init();
  }

  @override
  void dispose() {
    super.dispose();
    manager.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isOwnMessage =
        widget.message.authorId == widget.currentUser.uid;
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: isOwnMessage ? AppColors.orangeAccent : AppColors.greyAccent,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(8),
          topRight: const Radius.circular(8),
          bottomLeft: isOwnMessage ? const Radius.circular(8) : Radius.zero,
          bottomRight: isOwnMessage ? Radius.zero : const Radius.circular(8),
        ),
      ),
      constraints: BoxConstraints(maxWidth: size.width * 0.7),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          isPlaying
              ? InkWell(
                  onTap: () {
                    manager.player.pause();
                    setState(() {
                      isPlaying = !isPlaying;
                    });
                  },
                  child: const Icon(
                    Icons.pause_circle_filled_outlined,
                    size: 34,
                    color: Colors.white,
                  ),
                )
              : InkWell(
                  onTap: () {
                    manager.player.play();
                    setState(() {
                      isPlaying = !isPlaying;
                    });
                  },
                  child: const Icon(
                    Icons.play_circle_fill_outlined,
                    size: 34,
                    color: Colors.white,
                  ),
                ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: _buildProgressBar(isOwnMessage),
          ),
        ],
      ),
    );
  }

  StreamBuilder<DurationState> _buildProgressBar(bool isOwnMessage) {
    return StreamBuilder<DurationState>(
      stream: manager.durationState,
      builder: (context, snapshot) {
        final durationState = snapshot.data;
        final progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;
        return ProgressBar(
          thumbColor:
              isOwnMessage ? AppColors.whiteAccent : AppColors.orangeAccent,
          baseBarColor:
              isOwnMessage ? AppColors.orangeDark : const Color(0xFFC5C5C5),
          bufferedBarColor:
              isOwnMessage ? AppColors.whiteAccent : AppColors.orangeAccent,
          progressBarColor:
              isOwnMessage ? AppColors.whiteAccent : AppColors.orangeAccent,
          timeLabelLocation: TimeLabelLocation.none,
          progress: progress,
          buffered: buffered,
          total: total,
          onSeek: manager.player.seek,
        );
      },
    );
  }
}

class AudioPlayerManager {
  final String url;
  final player = AudioPlayer();
  Stream<DurationState>? durationState;

  AudioPlayerManager({required this.url});

  void init() {
    durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        player.positionStream,
        player.playbackEventStream,
        (position, playbackEvent) => DurationState(
              progress: position,
              buffered: playbackEvent.bufferedPosition,
              total: playbackEvent.duration,
            ));
    player.setUrl(url);
  }

  void dispose() {
    player.dispose();
  }
}

class DurationState {
  const DurationState({
    required this.progress,
    required this.buffered,
    this.total,
  });

  final Duration progress;
  final Duration buffered;
  final Duration? total;
}
