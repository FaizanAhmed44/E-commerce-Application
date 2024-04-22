import 'dart:convert';

import 'package:amazon_clone/constant/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void ErrorHandling({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      ShowSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      ShowSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      ShowSnackBar(context, response.body);
  }
}
