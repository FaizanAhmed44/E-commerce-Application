import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      child: Row(
        children: [
          RichText(
              text: TextSpan(
                  text: "Hello, ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                  children: [
                TextSpan(
                  text: user.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}
