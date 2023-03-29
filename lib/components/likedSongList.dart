import 'package:flutter/material.dart';
import 'package:reposer/db/songDB.dart';
import '../entities/secondsToMinute.dart';
import '../class/song.dart';

List<String> musicTitle = [
  'Music A',
  'Music B',
  'Music C',
];

List<int> musicTime = [
  60,
  59,
  189,
];

class likedSongList extends StatefulWidget {
  @override
  State<likedSongList> createState() => _likedSongListState();
}

class _likedSongListState extends State<likedSongList> {
  late List<Song> songs;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshLikedSongs();
  }

  Future refreshLikedSongs() async {
    setState(() {
      isLoading = true;
    });
    // TODO change to readLikedSong later on
    this.songs = await SongDatabase.instance.readAllSong();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          for (int i = 0; i < musicTime.length; i++)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      musicTitle[i],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        convertSecondsToMinute(timeInSecond: musicTime[i]),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
