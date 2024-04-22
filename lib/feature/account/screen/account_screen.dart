import 'package:amazon_clone/feature/account/widget/topButtons.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class AccountScreen extends StatelessWidget {
  static const String routeName = "/account-screen";
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
              flexibleSpace: Container(
                  // decoration: const BoxDecoration(
                  //   gradient: GlobalVariables.appBarGradient,
                  // ),
                  ),
              title: const Text(
                "Profile",
                style: TextStyle(
                    // color: GlobalVariables.mainColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ).px(150)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const CircleAvatar(
                radius: 55,
                backgroundColor: Colors.black26,
                backgroundImage: NetworkImage(
                    'https://st3.depositphotos.com/15648834/17930/v/450/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg'),
              ),
              const SizedBox(height: 10),
              user.name.text.bold.size(21).make(),
              const TopButtons(),
            ],
          ),
        ));
  }
}
