import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String _token = "";
  DateTime? _expiryDate;
  late String _userId;

  bool get isAuth => token != "";

  String get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return "";
  }

  String get userId => _userId;

  Future<void> _auth(String email, String pass, String urlSegment) async {
    final url =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyD02N-TnxnlKXWAacx0z6Qw-jL2vfQShe4';
    try {
      var response = await http.post(Uri.parse(url),
          body: json.encode({
            "email": email,
            "password": pass,
            "returnSecureToken": true,
          }));
      final responseData = json.decode(response.body);
      if (responseData["error"] != null) {
        throw HttpException(responseData["error"]["message"]);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> signup(String email, String pass) async {
    return _auth(email, pass, "signupNewUser");
  }

  Future<void> login(String email, String pass) async {
    return _auth(email, pass, "verifyPassword");
  }
}
