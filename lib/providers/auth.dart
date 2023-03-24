import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  Future<void> signup(String email, String pass) async {}
}
