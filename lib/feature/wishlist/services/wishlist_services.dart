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

class WishlistServices {
  void removeToWishlist({
    required BuildContext context,
    required ProductModel product,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-wishlist/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      ErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            wishlist: jsonDecode(res.body)['wishlist'],
          );
          userProvider.setUserFromModel(user); //now update the user
        },
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }
}
