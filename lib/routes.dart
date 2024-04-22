import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/feature/account/widget/order_part.dart';
import 'package:amazon_clone/feature/address/screens/address_screen.dart';
import 'package:amazon_clone/feature/admin/screen/add_product_screen.dart';
import 'package:amazon_clone/feature/admin/screen/admin_screen.dart';
import 'package:amazon_clone/feature/admin/screen/order_screen.dart';
import 'package:amazon_clone/feature/admin/screen/profile_screen.dart';
import 'package:amazon_clone/feature/auth/screens/auth_screen.dart';
import 'package:amazon_clone/feature/home/screens/category_deal_screen.dart';
import 'package:amazon_clone/feature/home/screens/home_screen.dart';
import 'package:amazon_clone/feature/order_detail/screen/order_detail_screen.dart';
import 'package:amazon_clone/feature/order_detail/screen/order_review.dart';
import 'package:amazon_clone/feature/order_detail/screen/success_payment.dart';
import 'package:amazon_clone/feature/product/screen/product_detail_screen.dart';
import 'package:amazon_clone/feature/search/screen/search_screen.dart';
import 'package:amazon_clone/feature/wishlist/screen/whishlist_screen.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:amazon_clone/model/products.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoutes(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());
    case AddProduct.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProduct());
    case CategoryDealScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealScreen(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as ProductModel;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );
    case AddressScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddressScreen(),
      );
    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as OrderModel;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(
          order: order,
        ),
      );
    case WishListScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const WishListScreen(),
      );
    case Order.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Order(),
      );
    case OrderReview.routeName:
      var address = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderReview(address: address),
      );
    case SucessPayment.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SucessPayment(),
      );
    case OrderScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OrderScreen(),
      );
    case AdminScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminScreen(),
      );
    case AdminAccountScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AdminAccountScreen(),
      );
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(child: Text("Error on Route!")),
              ));
  }
}
