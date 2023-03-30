//Timer idea: https://www.flutterbeads.com/flutter-countdown-timer/

import 'package:flutter/material.dart';
import 'dart:async';

class SessionTimer extends StatefulWidget {
  Duration sessionDuration;
  SessionTimer({required Duration this.sessionDuration});

  @override
  State<SessionTimer> createState() => _SessionTimerState();
}

class _SessionTimerState extends State<SessionTimer> {
  Timer? countdownTimer;

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = widget.sessionDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        widget.sessionDuration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  @override
  initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    countdownTimer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(widget.sessionDuration.inMinutes.remainder(60));
    final seconds = strDigits(widget.sessionDuration.inSeconds.remainder(60));

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.all(35),
      // color: Colors.white.withOpacity(0.2),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.timer_sharp,
              color: Colors.white,
            ),
            Text(
              '${minutes}:${seconds}',
              style: const TextStyle(color: Colors.white, fontSize: 25.0),
            ),
          ],
        ),
      ),
    );
  }
}
