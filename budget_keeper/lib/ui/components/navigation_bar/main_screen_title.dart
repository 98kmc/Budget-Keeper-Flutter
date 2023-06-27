import 'package:flutter/material.dart';

class ScreenMainTitle extends StatelessWidget {
  final style = const TextStyle(
      fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold);
  const ScreenMainTitle({
    Key? key,
    required this.mainScreenTitle,
  }) : super(key: key);

  final String mainScreenTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            mainScreenTitle,
            style: style,
          )),
    );
  }
}
