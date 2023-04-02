import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../entities/sessionThemeTranslate.dart';
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
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          widget.sessionChosen(widget.title);
        },
        child: Container(
          margin: EdgeInsets.all(6.0),
          child: Column(
            children: <Widget>[
              widget.imgSrc,

              SizedBox(
                height: 7.0,
              ),
              // TODO 1 go change textStyleComponents.dart that so that it allows to change padding
              TransparentTitle(
                pressedAction: () {
                  widget.sessionChosen(widget.title);
                },
                // title: widget.title,
                title: convertSessionThemeLang(widget.title, context),
                titleSize: 15.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
