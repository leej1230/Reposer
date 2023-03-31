import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import 'package:reposer/class/seekbar.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class MusicPlayerMenu extends StatefulWidget {
  const MusicPlayerMenu({Key? key}) : super(key: key);

  @override
  State<MusicPlayerMenu> createState() => _MusicPlayerMenuState();
}

class _MusicPlayerMenuState extends State<MusicPlayerMenu> {
  AudioPlayer audioPlayer = AudioPlayer();
  String songAsset = 'assets/sounds/Sleep/Norvik - Pink Seas.mp3';

  // Future<void> _setupSession() async {
  //   await audioPlayer.setAudioSource(
  //     AudioSource.uri(
  //       Uri.parse('asset:///$songAsset'),
  //     ),
  //   );
  //   audioPlayer.play();
  // }

  @override
  void initState() {
    super.initState();
    // _setupSession();
    audioPlayer.setAudioSource(
      AudioSource.uri(
        Uri.parse('asset:///$songAsset'),
      ),
    );
    audioPlayer.play();
    // audioPlayer.setSourceAsset(ConcatenatingAudioSource(
    //   children: [
    //     AudioSource.asset('')
    //   ]
    // ),);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Stream<SeekBarData> get _seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
          audioPlayer.positionStream, audioPlayer.durationStream,
          (Duration curr, Duration? songDuration) {
        return SeekBarData(curr, songDuration ?? Duration.zero);
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        color: Colors.black,
                        size: 28.0,
                        Icons.favorite_border,
                      ),
                    ),
                    Center(
                      child: Text(
                        'Song Title',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<SeekBarData>(
                stream: _seekBarDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return SeekBar(
                    current: positionData?.current ?? Duration.zero,
                    duration: positionData?.songDuration ?? Duration.zero,
                    onChangEnd: audioPlayer.seek,
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  StreamBuilder<SequenceState?>(
                    stream: audioPlayer.sequenceStateStream,
                    builder: (context, index) {
                      return IconButton(
                        iconSize: 42.0,
                        onPressed: audioPlayer.hasPrevious
                            ? audioPlayer.seekToPrevious
                            : null,
                        icon: Icon(Icons.skip_previous),
                      );
                    },
                  ),
                  StreamBuilder<PlayerState>(
                    stream: audioPlayer.playerStateStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final playerState = snapshot.data;
                        final processingState = playerState!.processingState;

                        if (processingState == ProcessingState.loading ||
                            processingState == ProcessingState.buffering) {
                          return Container(
                            width: 64.0,
                            height: 64.0,
                            margin: const EdgeInsets.all(10.0),
                            child: CircularProgressIndicator(),
                          );
                        } else if (!audioPlayer.playing) {
                          return IconButton(
                            onPressed: audioPlayer.play,
                            iconSize: 80.0,
                            icon: Icon(Icons.play_circle_outline_rounded),
                          );
                        } else if (processingState !=
                            ProcessingState.completed) {
                          return IconButton(
                            onPressed: audioPlayer.pause,
                            iconSize: 80.0,
                            icon: Icon(Icons.pause_circle_outline_rounded),
                          );
                        }
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  StreamBuilder<SequenceState?>(
                    stream: audioPlayer.sequenceStateStream,
                    builder: (context, index) {
                      return IconButton(
                        iconSize: 42.0,
                        onPressed:
                            audioPlayer.hasNext ? audioPlayer.seekToNext : null,
                        icon: Icon(Icons.skip_next),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
