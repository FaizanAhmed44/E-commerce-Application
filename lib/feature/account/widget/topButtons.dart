import 'package:amazon_clone/feature/account/widget/order_part.dart';
import 'package:amazon_clone/feature/account/services/account_services.dart';
import 'package:amazon_clone/feature/wishlist/screen/whishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 28,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.wallet_travel,
                  size: 25,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 28,
                ),
                "Payment Methods".text.bold.size(20).make()
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
            Navigator.pushNamed(context, Order.routeName);
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
                  "My Orders".text.bold.size(20).make()
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
            Navigator.pushNamed(context, WishListScreen.routeName);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.favorite_outline,
                    size: 25,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 28,
                  ),
                  "My WishList".text.bold.size(20).make()
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
    );
  }
}
