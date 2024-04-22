import 'dart:convert';

import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/model/products.dart';
import 'package:amazon_clone/model/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constant/error_handling.dart';
import '../../../constant/utils.dart';

class ProductDetailServices {
  void addToCart({
    required BuildContext context,
    required ProductModel product,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
        }),
      );

      ErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            cart: jsonDecode(res.body)['cart'],
          ); // just change the cart part and the overall user was same
          userProvider.setUserFromModel(user); //now update the user
        },
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }

  void addToWishlist({
    required BuildContext context,
    required ProductModel product,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-wishlist'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
        }),
      );

      ErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            wishlist: jsonDecode(res.body)['wishlist'],
          ); // just change the cart part and the overall user was same
          userProvider.setUserFromModel(user); //now update the user
        },
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }

  void rateProduct({
    required BuildContext context,
    required ProductModel product,
    required double rating,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );

      ErrorHandling(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }
}
