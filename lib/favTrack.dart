import 'package:flutter/material.dart';
import 'package:reposer/components/scaffoldTemplate.dart';
import 'package:reposer/components/searchBar.dart';
import 'entities/secondsToMinute.dart';

class FavoriteTracks extends StatelessWidget {
  List<String> musicTitle = [
    'Music A',
    'Music B',
    'Music C',
  ];

  List<int> musicTime = [
    60,
    59,
    189,
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      body: Expanded(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background/11.jpg'),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: SafeArea(
            child: Expanded(
              child: Center(
                child: Column(
                  children: [
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 30.0, horizontal: 10.0),
                          child: Text(
                            'Favorite Tracks',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 25.0),
                          child: SearchBar(),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 15.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(28)),
                          color: Colors.white.withOpacity(0.3),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              for (int i = 0; i < musicTime.length; i++)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Icon(
                                          Icons.play_arrow_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Text(
                                          musicTitle[i],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: Text(
                                            convertSecondsToMinute(
                                                timeInSecond: musicTime[i]),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
