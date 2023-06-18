import 'package:arduino/constants.dart';
import 'package:flutter/material.dart';

class RoundedBoxWidget extends StatelessWidget {
  const RoundedBoxWidget({
    Key? key,
    required this.title,
    this.isActive = false,
  }) : super(key: key);

  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 32,
      ),
      decoration: BoxDecoration(
        color: isActive ? primaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: primaryColor),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
