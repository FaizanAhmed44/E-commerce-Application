import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final int maxlines;
  final bool isTrue;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.text,
    this.maxlines = 1,
    this.isTrue = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isTrue,
      decoration: InputDecoration(
        hintText: text,
        suffixIcon: GestureDetector(
          child: text == "*********"
              ? const Icon(Icons.remove_red_eye).pOnly(right: 12)
              : const SizedBox(),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black45,
          ),
          borderRadius: BorderRadius.all(Radius.circular(34)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black45,
          ),
          borderRadius: BorderRadius.all(Radius.circular(34)),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Enter your $text";
        }
        return null;
      },
      maxLines: maxlines,
    );
  }
}
