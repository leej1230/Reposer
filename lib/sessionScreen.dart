import 'package:flutter/material.dart';
import 'components/scaffoldTemplate.dart';

class SessionScreen extends StatelessWidget {
  SessionScreen({required this.sessionGenre});

  final String sessionGenre;

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
            child: Text(
              'Session ${sessionGenre} sorry :(',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
      ),
    );
  }
}
