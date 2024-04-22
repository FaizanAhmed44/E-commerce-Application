import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/feature/admin/models/sales.dart';
import 'package:amazon_clone/model/order.dart';
import 'package:amazon_clone/model/products.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AdminServices {
  void SellProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double quantity,
      required double price,
      required String category,
      required List<File> images}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      final cloudinary = CloudinaryPublic('deboiyaee', 'tlw82att');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));

        imageUrls.add(res
            .secureUrl); //thi is the download url that we get from firebase or a upload url
      }

      ProductModel product = ProductModel(
        name: name,
        description: description,
        category: category,
        images: imageUrls,
        quantity: quantity,
        price: price,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      ErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          ShowSnackBar(context, "Product added sucessfully");
          Navigator.pop(context);
        },
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }

//get all the data
  Future<List<ProductModel>> fetchAllData(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final List<ProductModel> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-products'), headers: {
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

  void deleteProduct({
    required BuildContext context,
    required ProductModel product,
    required VoidCallback onSucess,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-products'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      ErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          onSucess();
        },
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }

  //get all the orders
  Future<List<OrderModel>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final List<OrderModel> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      ErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              orderList.add(
                OrderModel.fromJson(
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
    return orderList;
  }

//change order status
  void changeOrderStatus({
    required BuildContext context,
    required OrderModel order,
    required int status,
    required VoidCallback onSucess,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );

      ErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          onSucess();
        },
      );
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/analytics'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      ErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            var response = jsonDecode(res.body);
            totalEarning = response['totalEarnings'];
            sales = [
              Sales("Mobiles", response['MobilesEarnings']),
              Sales("Essentials", response['EssentialsEarnings']),
              Sales("Appliances", response['AppliancesEarnings']),
              Sales("Books", response['BooksEarnings']),
              Sales("Fashion", response['FashionEarnings']),
            ];
          });
    } catch (e) {
      ShowSnackBar(context, e.toString());
    }

    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }
}
