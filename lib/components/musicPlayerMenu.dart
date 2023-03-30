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
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
            children: <Widget>[],
          )
        ],
      ),
    );
  }
}
