import 'dart:convert';

import 'package:flywit/data/SessionManager.dart';
import 'package:http/http.dart' as http;

class NetworkUtil
{

  Future<http.Response> post(String url, Map<String, dynamic> params) async
  {
    var response = await http.post(url, body: params);
    return response;
  }

  Future<http.Response> get(String url) async
  {
    var response = await http.get(url, headers: {
      "Authorization" : "Bearer " + SessionManager.accessToken,
    });
    return response;
  }

}