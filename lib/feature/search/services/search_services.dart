import 'dart:convert';
import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/model/products.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchService {
//get all the data
  Future<List<ProductModel>> fetchSearchProducts(
      {required BuildContext context, required String searchQuery}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final List<ProductModel> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products/search/$searchQuery'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      ErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
                ProductModel.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
    return productList;
  }
}
