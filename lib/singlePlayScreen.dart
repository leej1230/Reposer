import 'package:flutter/material.dart';
import 'package:reposer/class/song.dart';
import 'package:reposer/components/musicPlayerMenu.dart';
import 'package:reposer/components/singleMusicPlayerMenu.dart';
import 'package:reposer/components/sessionTimer.dart';
import 'package:reposer/components/textStyleComponents.dart';
import 'package:reposer/entities/constants.dart';
import 'components/scaffoldTemplate.dart';
import 'achievement.dart';
import 'dart:math';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SingleSessionScreen extends StatelessWidget {
  SingleSessionScreen({required this.song});

  final Song song;

  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background/8.jpg'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Title
                Text(
                  LangLocal.of(context)!.favorite_tracks,
                  // 'Favorite Track',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                //  Image and Timer
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    //Image
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Image.asset(imageSources[
                                  Random().nextInt(imageSources.length)]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SingleMusicPlayerMenu(
                  song: song,
                ),
                //  Music Player
              ],
            ),
          ),
        ),
      ),
    );
  }
}
