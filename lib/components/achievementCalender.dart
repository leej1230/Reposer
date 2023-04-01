import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class AchievementCalender extends StatefulWidget {
  @override
  State<AchievementCalender> createState() => _AchievementCalenderState();
}

class _AchievementCalenderState extends State<AchievementCalender> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, day) {
          return Text(
            DateFormat.yMMMM().format(day),
            style: TextStyle(color: Colors.white),
          );
        },
        dowBuilder: (context, day) {
          return Center(
            child: Text(
              DateFormat.E().format(day),
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      ),
      calendarStyle: CalendarStyle(
        defaultTextStyle: TextStyle(
          color: Colors.white,
        ),
        disabledTextStyle: TextStyle(
          color: Colors.white,
        ),
        holidayTextStyle: TextStyle(
          color: Colors.white,
        ),
        outsideTextStyle: TextStyle(
          color: Colors.white,
        ),
        todayTextStyle: TextStyle(
          color: Colors.white,
        ),
        weekendTextStyle: TextStyle(
          color: Colors.white,
        ),
        weekNumberTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
