import 'dart:async';
import 'package:flutter/material.dart';

class TypingText extends StatefulWidget {
  final String text;

  const TypingText({super.key, required this.text});

  @override
  State<TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText> {
  String displayed = "";
  int index = 0;

  @override
  void initState() {
    super.initState();
    type();
  }

  void type() {
    Timer.periodic(const Duration(milliseconds: 40), (timer) {
      if (index < widget.text.length) {
        setState(() {
          displayed += widget.text[index];
          index++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(displayed);
  }
}