import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  const CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      this.color = const Color(0xFF704F38)});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 55),
        backgroundColor: color,
      ),
      child: text.text.color(Colors.white).size(19).bold.make(),
    );
  }
}
