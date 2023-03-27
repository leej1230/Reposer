import 'package:flutter/material.dart';
import 'package:reposer/components/scaffoldTemplate.dart';
import 'components/achievementCalender.dart';

class AchievementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(0.7, 0.0),
            image: AssetImage('assets/images/background/10.jpg'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: SafeArea(
          child: Expanded(
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Achievement',
                    style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AchievementCalender(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
