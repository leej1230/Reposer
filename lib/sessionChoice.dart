import 'package:flutter/material.dart';
import './components/searchBar.dart';
import './components/componentCards.dart';

class SessionChoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
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
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 27.0),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SearchBar(),
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
        ));
  }
}
