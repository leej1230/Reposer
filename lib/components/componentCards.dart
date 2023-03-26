import 'package:flutter/material.dart';
import 'card.dart';

class ComponentCards extends StatelessWidget {
  ComponentCards({required this.cardRow, required this.cardCol});

  final int cardRow;
  final int cardCol;

  static List<String> titles = [
    'Relaxation',
    'Stress Free',
    'Peaceful',
    'Meditation',
    'Sleep',
    'Motivation'
  ];

  static List<String> imageSources = [
    'assets/images/background/7.jpg',
    'assets/images/background/7.jpg',
    'assets/images/background/9.jpg',
    'assets/images/background/9.jpg',
    'assets/images/background/11.jpg',
    'assets/images/background/11.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          for (int i = 0; i < this.cardRow; i++)
            Row(
              children: <Widget>[
                for (int j = 0; j < this.cardCol; j++)
                  SessionCard(
                    title: titles[i * this.cardCol + j],
                    imgSrc: Image.asset(
                      imageSources[i * this.cardCol + j],
                    ),
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
      ),
    );
  }
}
