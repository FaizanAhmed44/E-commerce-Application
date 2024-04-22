import 'package:amazon_clone/model/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    token: '',
    type: '',
    cart: [],
    wishlist: [],
  );

  User get user => _user;

//this function is used for update the user and notify the whole device that data of user has been updated
  void setUser(String user) {
    _user = User.fromJson(user); //first decode then save in _user
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
