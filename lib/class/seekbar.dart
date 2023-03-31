import 'package:flutter/material.dart';
import 'dart:math';

class SeekBarData {
  final Duration current;
  final Duration songDuration;

  SeekBarData(this.current, this.songDuration);
}

class SeekBar extends StatefulWidget {
  final Duration current;
  final Duration duration;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangEnd;

  const SeekBar(
      {Key? key,
      required this.current,
      required this.duration,
      this.onChanged,
      this.onChangEnd})
      : super(key: key);

  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;

  String _formatDuration(Duration? duration) {
    if (duration == null) {
      return '--:--';
    } else {
      String minutes = duration.inMinutes.toString().padLeft(2, '0');
      String seconds =
          duration.inSeconds.remainder(60).toString().padLeft(2, '0');
      return '$minutes:$seconds';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Slider(
                activeColor: Colors.black.withOpacity(0.8),
                inactiveColor: Colors.black.withOpacity(0.8),
                thumbColor: Colors.black,
                min: 0.0,
                max: widget.duration.inMilliseconds.toDouble(),
                value: min(
                  _dragValue ?? widget.current.inMilliseconds.toDouble(),
                  widget.duration.inMilliseconds.toDouble(),
                ),
                onChanged: (value) {
                  setState(() {
                    _dragValue = value;
                  });
                  if (widget.onChanged != null) {
                    widget.onChanged!(
                      Duration(
                        milliseconds: value.round(),
                      ),
                    );
                  }
                },
                onChangeEnd: (value) {
                  if (widget.onChangEnd != null) {
                    widget.onChangEnd!(
                      Duration(
                        milliseconds: value.round(),
                      ),
                    );
                  }
                  _dragValue = null;
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDuration(widget.current),
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.white,
              ),
            ),
            Text(
              _formatDuration(widget.duration),
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
