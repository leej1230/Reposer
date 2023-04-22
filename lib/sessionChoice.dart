import 'package:flutter/material.dart';
import './components/searchBar.dart';
import './components/componentCards.dart';
import './components/scaffoldTemplate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              flex: 2,
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
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          LangLocal.of(context)!.session_themes,
                          // 'Session Themes',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
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
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: kBottomNavigationBarHeight + 20.0),
                child: SingleChildScrollView(
                  child: ComponentCards(
                    cardCol: 2,
                    cardRow: 3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
