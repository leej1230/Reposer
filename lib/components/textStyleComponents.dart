import 'package:flutter/material.dart';

class TransparentTitle extends StatefulWidget {
  final void Function() pressedAction;
  final String title;
  final double titleSize;

  const TransparentTitle(
      {Key? key,
      required this.pressedAction,
      required this.title,
      required this.titleSize})
      : super(key: key);

  @override
  State<TransparentTitle> createState() => _TransparentTitleState();
}

class _TransparentTitleState extends State<TransparentTitle> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.pressedAction,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 3.0,
          horizontal: 14.0,
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: widget.titleSize,
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white.withOpacity(0.2),
      ),
    );
  }
}
