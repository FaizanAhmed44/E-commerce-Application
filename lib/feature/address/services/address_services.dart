import 'dart:convert';
import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/model/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../constant/error_handling.dart';
import '../../../constant/utils.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'address': address,
        }),
      );

      ErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            address: jsonDecode(res.body)['address'],
          ); // just change the cart part and the overall user was same

          userProvider.setUserFromModel(user); //now update the user
        },
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }

  void placeOrder(
      {required BuildContext context,
      required String address,
      required double totalPrice,
      required}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      http.Response res = await http.post(
        Uri.parse('$uri/api/order'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'cart': userProvider.user.cart,
          'address': address,
          'totalPrice': totalPrice,
        }),
      );

      ErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          ShowSnackBar(context, "Your Order Has Been Placed Sucessfully");
          User user = userProvider.user.copyWith(
            cart: [],
          ); // just change the cart part and the overall user was same

          userProvider.setUserFromModel(user); //now update the user
        },
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }
}
