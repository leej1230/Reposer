import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reposer/entities/sessionThemeTranslate.dart';
import 'package:reposer/sessionScreen.dart';
import 'card.dart';
import 'textStyleComponents.dart';
import 'package:reposer/entities/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ComponentCards extends StatefulWidget {
  ComponentCards({required this.cardRow, required this.cardCol});

  final int cardRow;
  final int cardCol;

  String chosenSessionGenre = '';

  @override
  State<ComponentCards> createState() => _ComponentCardsState();
}

class _ComponentCardsState extends State<ComponentCards> {
  Duration duration = const Duration(minutes: 10, seconds: 00);
  bool pickTime = false;

  @override
  Widget build(BuildContext context) {
    if (!pickTime) {
      return Column(
        // shrinkWrap: true,
        children: <Widget>[
          for (int i = 0; i < this.widget.cardRow; i++)
            Row(
              children: <Widget>[
                for (int j = 0; j < this.widget.cardCol; j++)
                  SessionCard(
                    // title: convertSessionThemeLang(
                    // titles[i * this.widget.cardCol + j], context),
                    title: titles[i * this.widget.cardCol + j],
                    imgSrc: Image.asset(
                      imageSources[i * this.widget.cardCol + j],
                    ),
                    sessionChosen: (String t) {
                      setState(() {
                        pickTime = true;
                        widget.chosenSessionGenre = t;
                      });
                    },
                  ),
                // SessionCard(
                //   title: 'Relaxation',
                //   imgSrc: Image.asset(
                //     'assets/images/background/10.jpg',
                //     fit: BoxFit.fitHeight,
                //   ),
                // ),
              ],
            ),
        ],
      );
    }
    return Container(
      padding: EdgeInsets.all(6.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              LangLocal.of(context)!.starting_genre_session(
                  convertSessionThemeLang(widget.chosenSessionGenre, context)),
              // 'Starting ${widget.chosenSessionGenre} Session',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 2.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white.withOpacity(0.3),
            ),
            child: CupertinoTimerPicker(
              backgroundColor: Colors.transparent,
              mode: CupertinoTimerPickerMode.ms,
              initialTimerDuration: duration,
              // This is called when the user changes the timer's
              // duration.
              onTimerDurationChanged: (Duration newDuration) {
                setState(() => duration = newDuration);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SessionScreen(
                            sessionGenre: widget.chosenSessionGenre,
                            sessionTime: duration,
                          );
                        },
                      ),
                    );
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                    ),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.white.withOpacity(0.2),
                    ),
                  ),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 5.0),
                    child: Text(
                      LangLocal.of(context)!.start,
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      pickTime = false;
                    });
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                    ),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 5.0),
                    child: Text(
                      LangLocal.of(context)!.cancel,
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
