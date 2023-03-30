import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reposer/sessionScreen.dart';
import 'card.dart';
import 'textStyleComponents.dart';
import 'package:reposer/entities/constants.dart';

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
              'Starting ${widget.chosenSessionGenre} Session',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          CupertinoTimerPicker(
            backgroundColor: Colors.white.withOpacity(0.3),
            mode: CupertinoTimerPickerMode.ms,
            initialTimerDuration: duration,
            // This is called when the user changes the timer's
            // duration.
            onTimerDurationChanged: (Duration newDuration) {
              setState(() => duration = newDuration);
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TransparentTitle(
                    pressedAction: () {
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
                    title: 'Start',
                    titleSize: 25.0),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TransparentTitle(
                    pressedAction: () {
                      setState(() {
                        pickTime = false;
                      });
                    },
                    title: 'Cancel',
                    titleSize: 25.0),
              ),
            ],
          )
        ],
      ),
    );
  }
}
