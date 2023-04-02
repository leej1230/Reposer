import 'package:flutter/material.dart';
import 'package:reposer/components/musicPlayerMenu.dart';
import 'package:reposer/components/sessionTimer.dart';
import 'package:reposer/components/textStyleComponents.dart';
import 'package:reposer/entities/constants.dart';
import 'package:reposer/entities/sessionThemeTranslate.dart';
import 'components/scaffoldTemplate.dart';
import 'achievement.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SessionScreen extends StatelessWidget {
  SessionScreen({required this.sessionGenre, required this.sessionTime});

  final String sessionGenre;
  final Duration sessionTime;

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
                  LangLocal.of(context)!.session_genre(
                      convertSessionThemeLang(sessionGenre, context)),
                  // 'Session ${sessionGenre}',
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
                                  convertGenreForIndex[this.sessionGenre] ??
                                      0]),
                            ),
                            SizedBox(
                              height: 7.0,
                            ),
                            TransparentTitle(
                              pressedAction: () {},
                              title: convertSessionThemeLang(
                                  titles[
                                      convertGenreForIndex[this.sessionGenre] ??
                                          0],
                                  context),
                              titleSize: 15.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    //  Timer
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: SessionTimer(
                          sessionDuration: sessionTime,
                          afterTimerFunction: () {
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AchievementScreen(
                                afterSession: true,
                              );
                            }));
                          },
                        ),
                      ),
                    )
                  ],
                ),
                MusicPlayerMenu(genre: convertGenreForDB[sessionGenre] ?? ''),
                //  Music Player
              ],
            ),
          ),
        ),
      ),
    );
  }
}
