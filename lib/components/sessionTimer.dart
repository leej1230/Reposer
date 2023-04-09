//Timer idea: https://www.flutterbeads.com/flutter-countdown-timer/

import 'package:flutter/material.dart';
import 'dart:async';

class SessionTimer extends StatefulWidget {
  Duration sessionDuration;
  final Function afterTimerFunction;

  SessionTimer({
    required this.sessionDuration,
    required this.afterTimerFunction,
  });

  @override
  State<SessionTimer> createState() => _SessionTimerState();
}

class _SessionTimerState extends State<SessionTimer>
    with WidgetsBindingObserver {
  Timer? countdownTimer;
  AppLifecycleState? _appLifecycleState;
  bool singleFlag = false;

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = widget.sessionDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
        widget.afterTimerFunction();
      } else {
        widget.sessionDuration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void stopTimer() {
    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }
  }

  @override
  void initState() {
    super.initState();

    startTimer();

    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    stopTimer();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    setState(() {
      _appLifecycleState = state;
    });
    if (_appLifecycleState == AppLifecycleState.paused ||
        _appLifecycleState == AppLifecycleState.inactive) {
      singleFlag = false;
      stopTimer();
    }

    if (_appLifecycleState == AppLifecycleState.resumed && !singleFlag) {
      singleFlag = true;
      startTimer();
    }
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
              size: 40.0,
            ),
            Text(
              '${minutes}:${seconds}',
              style: const TextStyle(color: Colors.white, fontSize: 35.0),
            ),
          ],
        ),
      ),
    );
  }
}
