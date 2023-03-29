import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'textStyleComponents.dart';

class SessionCard extends StatefulWidget {
  SessionCard(
      {required this.title, required this.imgSrc, required this.sessionChosen});

  final String title;
  final Image imgSrc;
  final void Function(String t) sessionChosen;

  @override
  State<SessionCard> createState() => _SessionCardState();
}

class _SessionCardState extends State<SessionCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(6.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: widget.imgSrc,
              onTap: () {
                widget.sessionChosen(widget.title);
              },
            ),
            SizedBox(
              height: 7.0,
            ),
            // TODO 1 go change textStyleComponents.dart that so that it allows to change padding
            TransparentTitle(
              pressedAction: () {},
              title: widget.title,
              titleSize: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}
