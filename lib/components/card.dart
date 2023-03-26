import 'package:flutter/material.dart';
import 'textStyleComponents.dart';

class SessionCard extends StatelessWidget {
  SessionCard({required this.title, required this.imgSrc});

  final String title;
  final Image imgSrc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(6.0),
        child: Column(
          children: <Widget>[
            FittedBox(
              fit: BoxFit.fitHeight,
              child: imgSrc,
            ),
            SizedBox(
              height: 7.0,
            ),
            // TODO 1 go change textStyleComponents.dart that so that it allows to change padding
            TransparentTitle(
              pressedAction: () {},
              title: title,
              titleSize: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
