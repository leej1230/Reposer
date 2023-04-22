import 'package:flutter/material.dart';
import 'package:reposer/components/scaffoldTemplate.dart';
import 'components/streak.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AchievementScreen extends StatelessWidget {
  final bool afterSession;

  const AchievementScreen({super.key, required this.afterSession});

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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    LangLocal.of(context)!.achievement,
                    // 'Achievement',
                    style: TextStyle(
                      fontSize: 35.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: Streak(
                    afterSession: this.afterSession,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
