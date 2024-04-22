import 'dart:convert';
import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/model/products.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeService {
//get all the data
  Future<List<ProductModel>> fetchCategoryProducts(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final List<ProductModel> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products?category=$category'), headers: {
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

  Future<List<ProductModel>> fetchDealOfDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final List<ProductModel> productsList = [];
    // ProductModel product = ProductModel(
    //   name: '',
    //   description: '',
    //   category: '',
    //   images: [],
    //   quantity: 0,
    //   price: 0,
    // );
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      ErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            // product = ProductModel.fromJson(res.body);
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productsList.add(
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
    // return product;
    return productsList;
  }
}
