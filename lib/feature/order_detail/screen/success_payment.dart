import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SucessPayment extends StatelessWidget {
  static const String routeName = "/sucess-page";
  const SucessPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 90,
            ),
            Container(
              width: 400,
              height: 430,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('asset/images/sucess.PNG'),
                      fit: BoxFit.cover)),
            ),
            "Payment Sucess!".text.bold.size(29).make().centered(),
            "Your item will be shipped soon"
                .text
                .color(Colors.grey)
                .bold
                .size(15)
                .make()
                .centered(),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, BottomBar.routeName);
                Navigator.pushNamedAndRemoveUntil(
                    context, BottomBar.routeName, (route) => false);
              },
              child: Container(
                width: double.maxFinite,
                height: 70,
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: const Color.fromARGB(255, 4, 83, 148),
                ),
                child: "Continue"
                    .text
                    .bold
                    .color(Colors.white)
                    .xl2
                    .make()
                    .centered(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
