import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  Future<void> _auth(String email, String pass, String urlSegment) async {
    final url =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=AIzaSyD02N-TnxnlKXWAacx0z6Qw-jL2vfQShe4';
    var responde = await http.post(Uri.parse(url),
        body: json.encode(
            {"email": email, "password": pass, "returnSecureToken": true}));

    print(json.decode(responde.body));
  }

  Future<void> signup(String email, String pass) async {
    return _auth(email, pass, "signupNewUser");
  }

  Future<void> login(String email, String pass) async {
    return _auth(email, pass, "verifyPassword");
  }
}
