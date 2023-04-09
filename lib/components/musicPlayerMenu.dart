import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:just_audio/just_audio.dart';
import 'package:reposer/class/seekbar.dart';
import 'package:reposer/class/song.dart';
import 'package:reposer/db/songDB.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

class MusicPlayerMenu extends StatefulWidget {
  final String genre;
  const MusicPlayerMenu({Key? key, required this.genre}) : super(key: key);

  @override
  State<MusicPlayerMenu> createState() => _MusicPlayerMenuState();
}

class _MusicPlayerMenuState extends State<MusicPlayerMenu>
    with WidgetsBindingObserver {
  bool wasPlayed = true;
  AppLifecycleState? _appLifecycleState;
  AudioPlayer audioPlayer = AudioPlayer();
  List<Song> songs = [];

  _getInfo() async {
    // final manifestJson = await rootBundle.loadString('AssetManifest.json');
    // final manifest = json.decode(manifestJson);
    //
    // final assetPaths = manifest.keys
    //     .where((String key) => key.startsWith('assets/sounds/${widget.genre}'));
    // print(assetPaths);
    // return assetPaths;
    songs = await SongDatabase.instance.readGenreSong(widget.genre);
    songs.shuffle();
  }

  Future<void> _setMusic() async {
    await _getInfo();
    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        useLazyPreparation: true,
        children: [
          // Uri.parse('asset:///$songAsset'),
          for (final song in songs)
            AudioSource.uri(Uri.parse('asset:///${song.getSongUrl()}')),
        ],
      ),
    );
    audioPlayer.play();
    setState(() {
      songs;
    });
  }

  @override
  void initState() {
    super.initState();
    // audioPlayer.setSourceAsset(ConcatenatingAudioSource(
    //   children: [
    //     AudioSource.asset('')
    //   ]
    // ),);

    WidgetsBinding.instance!.addObserver(this);

    _setMusic();
  }

  @override
  void dispose() {
    audioPlayer.dispose();

    WidgetsBinding.instance!.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    setState(() {
      _appLifecycleState = state;
    });
    if (_appLifecycleState == AppLifecycleState.paused ||
        _appLifecycleState == AppLifecycleState.inactive) {
      audioPlayer.pause();
    }

    if (_appLifecycleState == AppLifecycleState.resumed) {
      if (wasPlayed) {
        audioPlayer.play();
      }
    }
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
                      child: StreamBuilder<SequenceState?>(
                        stream: audioPlayer.sequenceStateStream,
                        builder: (context, snapshot) {
                          final data = snapshot.data;
                          data?.currentIndex;
                          if ((data?.currentIndex ?? -1) == -1) {
                            return Icon(
                              color: Colors.black,
                              size: 28.0,
                              Icons.star,
                            );
                          } else {
                            if (songs[data?.currentIndex ?? -1].getIsLiked()) {
                              return GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  setState(() {
                                    songs[data?.currentIndex ?? -1]
                                        .setIsLiked(like: false);
                                  });
                                  SongDatabase.instance.updateLike(
                                      songs[data?.currentIndex ?? -1]);
                                },
                                child: Icon(
                                  color: Colors.white,
                                  size: 28.0,
                                  Icons.favorite,
                                ),
                              );
                            } else {
                              return GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  setState(() {
                                    songs[data?.currentIndex ?? -1]
                                        .setIsLiked(like: true);
                                  });
                                  SongDatabase.instance.updateLike(
                                      songs[data?.currentIndex ?? -1]);
                                },
                                child: Icon(
                                  color: Colors.white,
                                  size: 28.0,
                                  Icons.favorite_border,
                                ),
                              );
                            }
                          }
                        },
                      ),

                      // Icon(
                      //   color: Colors.black,
                      //   size: 28.0,
                      //   Icons.favorite_border,
                      // ),
                    ),
                    Center(
                      child: StreamBuilder<SequenceState?>(
                        stream: audioPlayer.sequenceStateStream,
                        builder: (context, snapshot) {
                          final data = snapshot.data;
                          data?.currentIndex;
                          return (data?.currentIndex ?? -1) == -1
                              ? Text('Sorry :(')
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 50.0,
                                    vertical: 10.0,
                                  ),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                      '${songs[data?.currentIndex ?? -1].getSongTitle()}',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        // overflow:
                                      ),
                                    ),
                                  ),
                                );
                        },
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
                            onPressed: () {
                              audioPlayer.play();
                              wasPlayed = true;
                            },
                            iconSize: 80.0,
                            icon: Icon(
                              Icons.play_circle_outline_rounded,
                              color: Colors.white,
                            ),
                          );
                        } else if (processingState !=
                            ProcessingState.completed) {
                          return IconButton(
                            onPressed: () {
                              audioPlayer.pause();
                              wasPlayed = false;
                            },
                            iconSize: 80.0,
                            icon: Icon(
                              Icons.pause_circle_outline_rounded,
                              color: Colors.white,
                            ),
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
