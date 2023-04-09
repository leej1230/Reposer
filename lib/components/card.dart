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
                height: 5.0,
              ),
              TextButton(
                onPressed: () {
                  widget.sessionChosen(widget.title);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.white.withOpacity(0.2),
                ),
                child: Text(
                  convertSessionThemeLang(widget.title, context),
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
