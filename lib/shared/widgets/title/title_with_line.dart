import 'package:flutter/material.dart';

class TitleWithLine extends StatelessWidget {
  TitleWithLine({
    super.key,
    required this.title,
    this.textColor,
    this.lineColor,
  });

  final String title;
  Color? textColor;
  Color? lineColor;

  @override
  Widget build(BuildContext context) {
    textColor ??= Theme.of(context).colorScheme.onSurface;
    lineColor ??= Theme.of(context).colorScheme.primary;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 4),
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: lineColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
