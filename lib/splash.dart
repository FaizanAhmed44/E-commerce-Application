import 'dart:async';

import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/feature/admin/screen/admin_screen.dart';
import 'package:amazon_clone/feature/admin/screen/profile_screen.dart';
import 'package:amazon_clone/feature/auth/screens/auth_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Provider.of<UserProvider>(context, listen: false).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context, listen: false).user.type ==
                  'User'
              ? Navigator.pushNamed(context, BottomBar.routeName)
              : Navigator.pushNamedAndRemoveUntil(
                  context, AdminScreen.routeName, (route) => false)
          : Navigator.pushNamed(context, AuthScreen.routeName);
    });
    print("Kha");
    // Timer(const Duration(seconds: 2), () {
    //   if (Provider.of<UserProvider>(context, listen: false)
    //       .user
    //       .token
    //       .isNotEmpty) {
    //     if (Provider.of<UserProvider>(context, listen: false).user.type ==
    //         'User') {
    //       Navigator.pushNamed(context, BottomBar.routeName);
    //     } else {
    //       Navigator.pushNamedAndRemoveUntil(
    //           context, AdminScreen.routeName, (route) => false);
    //     }
    //   } else {
    //     Navigator.pushNamed(context, AuthScreen.routeName);
    //   }
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          const SizedBox(
            height: 230,
          ),
          Container(
            width: 500,
            height: 400,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/images/logo4.png'),
                    fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }
}
