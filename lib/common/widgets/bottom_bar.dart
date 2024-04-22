import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/feature/account/screen/account_screen.dart';
import 'package:amazon_clone/feature/cart/screen/cart_screen.dart';
import 'package:amazon_clone/feature/home/screens/home_screen.dart';
import 'package:amazon_clone/feature/wishlist/screen/whishlist_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as bad;
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = "/actual-home";
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const WishListScreen(),
    const CartScreen(),
    const AccountScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartLength =
        Provider.of<UserProvider>(context, listen: false).user.cart.length;
    final wishlistLength =
        Provider.of<UserProvider>(context, listen: false).user.wishlist.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.mainColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? const Color.fromARGB(255, 4, 83, 148)
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? const Color.fromARGB(255, 4, 83, 148)
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: bad.Badge(
                badgeContent: Text(wishlistLength.toString()),
                badgeStyle: const bad.BadgeStyle(
                    badgeColor: Colors.white, elevation: 0),
                child: const Icon(Icons.favorite_outline),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 2
                          ? const Color.fromARGB(255, 4, 83, 148)
                          : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: bad.Badge(
                  badgeContent: Text(cartLength.toString()),
                  badgeStyle: const bad.BadgeStyle(
                      badgeColor: Colors.white, elevation: 0),
                  child: const Icon(Icons.shopping_cart_outlined),
                )),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 3
                        ? const Color.fromARGB(255, 4, 83, 148)
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.person_outline_outlined),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
