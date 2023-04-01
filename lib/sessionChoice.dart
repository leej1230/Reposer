import 'package:flutter/material.dart';
import './components/searchBar.dart';
import './components/componentCards.dart';
import './components/scaffoldTemplate.dart';

class SessionChoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      body: Container(
        color: Color(0xFF15002c),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SizedBox.expand(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/background/10.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              // flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 27.0),
                    child: Text(
                      'Session Themes',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 39.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              // Widget that will return container that contains rows
              // and columns of contents by inputting number of
              // rows and columns
            ),
            Expanded(
              flex: 3,
              child: ComponentCards(
                cardCol: 2,
                cardRow: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
