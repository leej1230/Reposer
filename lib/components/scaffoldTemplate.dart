import 'package:flutter/material.dart';
import 'package:reposer/main.dart';
import '../achievement.dart';
import '../favTrack.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScaffoldTemplate extends StatelessWidget {
  ScaffoldTemplate({required this.body});

  Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: body,
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                },
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 35.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FavoriteTracks();
                  }));
                },
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 35.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AchievementScreen();
                  }));
                },
                child: Icon(
                  FontAwesomeIcons.crown,
                  color: Colors.white,
                  size: 35.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
