import 'package:flutter/material.dart';
import 'package:reposer/components/singleMusicPlayerMenu.dart';
import 'package:reposer/db/songDB.dart';
import '../class/song.dart';
import '../singlePlayScreen.dart';

// List<String> musicTitle = [
//   'Music A',
//   'Music B',
//   'Music C',
// ];

class likedSongList extends StatefulWidget {
  const likedSongList({super.key});

  @override
  State<likedSongList> createState() => _likedSongListState();
}

class _likedSongListState extends State<likedSongList> {
  List<Song>? songs;
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

    this.songs = await SongDatabase.instance.readLikedSong();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!this.isLoading) {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            for (final song in this.songs ?? [])
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SingleSessionScreen(song: song);
                          }));
                        },
                        child: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          song.getSongTitle(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: song.getIsLiked()
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  song.setIsLiked(like: false);
                                  SongDatabase.instance.updateLike(song);
                                });
                              },
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  song.setIsLiked(like: true);
                                  SongDatabase.instance.updateLike(song);
                                });
                              },
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ],
                ),
              )
          ],
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      );
    }
  }
}
