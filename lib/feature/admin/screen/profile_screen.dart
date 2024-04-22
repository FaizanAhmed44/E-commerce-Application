import 'package:amazon_clone/feature/account/services/account_services.dart';
import 'package:amazon_clone/feature/account/widget/order_part.dart';
import 'package:amazon_clone/feature/admin/screen/add_product_screen.dart';
import 'package:amazon_clone/feature/admin/screen/order_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminAccountScreen extends StatelessWidget {
  static const String routeName = "/admin-account-screen";
  const AdminAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          const CircleAvatar(
            radius: 67,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(
              'asset/images/admin.png',
            ),
          ),
          const SizedBox(height: 10),
          user.name.text.bold.size(21).make(),
          // const TopButtons(),
          const SizedBox(
            height: 48,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.person_outline,
                    size: 25,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                  "Your Profile".text.bold.size(20).make()
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color.fromARGB(255, 4, 83, 148),
              )
            ],
          ).px20(),
          const SizedBox(
            height: 14,
          ),
          const Divider(
            color: Colors.black26,
            thickness: 0.5,
          ).px16(),
          const SizedBox(
            height: 14,
          ),
          GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, OrderScreen.routeName);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.outbox_rounded,
                      size: 25,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    "Orders".text.bold.size(20).make()
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromARGB(255, 4, 83, 148),
                )
              ],
            ).px20(),
          ),
          const SizedBox(
            height: 14,
          ),
          const Divider(
            color: Colors.black26,
            thickness: 0.5,
          ).px16(),
          const SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.settings_outlined,
                    size: 25,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                  "Settings".text.bold.size(20).make()
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color.fromARGB(255, 4, 83, 148),
              )
            ],
          ).px20(),
          const SizedBox(
            height: 14,
          ),
          const Divider(
            color: Colors.black26,
            thickness: 0.5,
          ).px16(),
          const SizedBox(
            height: 14,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AddProduct.routeName);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.add,
                      size: 25,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    "Add product".text.bold.size(20).make()
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromARGB(255, 4, 83, 148),
                )
              ],
            ).px20(),
          ),
          const SizedBox(
            height: 14,
          ),
          const Divider(
            color: Colors.black26,
            thickness: 0.5,
          ).px16(),
          const SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.help_center_outlined,
                    size: 25,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                  "Help Center".text.bold.size(20).make()
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color.fromARGB(255, 4, 83, 148),
              )
            ],
          ).px20(),
          const SizedBox(
            height: 14,
          ),
          const Divider(
            color: Colors.black26,
            thickness: 0.5,
          ).px16(),
          const SizedBox(
            height: 14,
          ),
          GestureDetector(
            onTap: () => AccountService().logOut(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.logout_outlined,
                      size: 25,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    "Log out".text.bold.size(20).make()
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromARGB(255, 4, 83, 148),
                )
              ],
            ).px20(),
          ),
        ],
      ),
    ));
  }
}
