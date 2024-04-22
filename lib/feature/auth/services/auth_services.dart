//getting user data, all of authentication part of the service,
import 'dart:convert';
import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/global_var.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/model/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//60294

class AuthService {
  //sign up the user
  void signUpUser({
    required String email,
    required String name,
    required BuildContext context,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        token: '',
        type: '',
        cart: [],
        wishlist: [],
      );

      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      ErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          ShowSnackBar(context, "Account created ! log in with credentials");
        },
      );
    } catch (e) {
      print("Hello 1");
      ShowSnackBar(context, e.toString());
    }
  }

  //for sign in
  void signInUser({
    required String email,
    required BuildContext context,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      print(res.body);
      ErrorHandling(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          //we also have to register in main.dart and each time when you outside the build function listen is false
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          // Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          //save token(data) into the device
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      print("Hello");
      ShowSnackBar(context, e.toString());
    }
  }

  //get user data
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
//for verifying if member is already a user or not
      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          //for getting all the data of the user
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      print("Hello");
      ShowSnackBar(context, e.toString());
    }
  }
}
