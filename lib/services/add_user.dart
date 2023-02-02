import 'dart:convert';
import '../globals/variables.dart';
import '../model/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<String?> registerUser({User? user}) async {
    try {
      await http
          .post(
            Uri.parse(addUserUrl),
            headers: {
              "Content-Type": "application/json",
              "Access-Control-Allow-Origin": "*",
              "responseType": "plain/text",
            },
            body: jsonEncode(user!.toMap()),
          )
          .then((value) {})
          .onError((error, stackTrace) {});
      return null;
    } catch (e) {
      return null;
    }
  }
}
