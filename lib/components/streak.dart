import 'package:flutter/material.dart';
import 'package:reposer/db/streakDateDB.dart';
import 'package:achievement_view/achievement_view.dart';

/*
* Possible pattern
* 1. Simply visiting the achievement page to see the streak
*     Condition -> afterSession is false
*     do -> fetch the data from db and show the steak and the last date
*       (There will be a possibility that database could be empty)
*
* 2. Jumped to the page after the session time is up
*     Condition -> afterSession is true
*     do -> update the data, show achievement widget if possible, show the newest data
* */

class Streak extends StatefulWidget {
  final bool afterSession;

  const Streak({super.key, required this.afterSession});

  @override
  State<Streak> createState() => _StreakState();
}

class _StreakState extends State<Streak> {
  Date? _date;

  @override
  void initState() {
    super.initState();
    _updateDate();
  }

  void show(BuildContext context) async {
    AchievementView(
      context,
      title: "Made a First Session of the Day!",
      subTitle: "Awesome Job! ",
      isCircle: true,
      listener: print,
    ).show();
  }

  Future<void> _getCurrentDate() async {
    final date = await DateDatabase.instance.getCurrentDate();
    setState(() {
      _date = date;
    });
  }

  Future<void> _updateDate() async {
    await _getCurrentDate();
    final currentUserDate = DateTime.now();
    // If user didn't jump from session timer
    if (!widget.afterSession) {
      return;
    }
    // User jumped from session timer but already has done session on same day
    if (_date != null && _date!.getDate().day == currentUserDate.day) {
      return;
    }

    show(context);

    final previousStreak = _date?.getStreak() ?? 0;
    final newStreak = (_date != null &&
            _date!.getDate().add(Duration(days: 1)).day == currentUserDate.day)
        ? previousStreak + 1
        : 1;

    final dateForUpdate =
        Date(date: currentUserDate.toString(), streak: newStreak);

    if (_date != null) {
      dateForUpdate.id = _date!.id;
      await DateDatabase.instance.updateDate(dateForUpdate);
    } else {
      await DateDatabase.instance.insertDate(dateForUpdate);
    }

    await _getCurrentDate();
  }

  @override
  Widget build(BuildContext context) {
    // _updateDate();
    return Container(
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 200.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.local_fire_department,
            color: Colors.white,
            size: 100.0,
          ),
          Center(
            child: Text(
              'Streak: ${_date?.getStreak() ?? 0}',
              style: TextStyle(
                fontSize: 35.0,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
    // return const Placeholder();
  }
}
