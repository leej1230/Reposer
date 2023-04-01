import 'package:flutter/material.dart';
import 'package:reposer/components/scaffoldTemplate.dart';
import 'package:reposer/components/searchBar.dart';
import 'package:reposer/singlePlayScreen.dart';
import 'class/song.dart';
import 'components/likedSongList.dart';
import 'components/singleMusicPlayerMenu.dart';

class FavoriteTracks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/11.jpg'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 10.0),
                      child: Text(
                        'Favorite Tracks',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 15.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(28)),
                      color: Colors.white.withOpacity(0.3),
                    ),
                    child: likedSongList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
