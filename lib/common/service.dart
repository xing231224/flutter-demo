import 'package:dio/dio.dart';
import 'package:flutter_application_1/utils/c_log_util.dart';
import 'package:flutter_application_1/utils/http_request.dart';

class LoginApi {
  static loginAuth(params) {
    final data = {
      "client_id": "yjyj",
      "grant_type": "yi-xrc-app-${params['password'] != null ? 'password' : 'phone'}",
      "state": 1,
      "scope": "server",
    };
    final headers = {"Authorization": "Basic eWp5ajp5anlq"};
    return HttpRequest.instance.post(
      '/auth/oauth2/token',
      data: {...data, ...params},
      contentType: Headers.formUrlEncodedContentType,
      headers: headers,
    );
  }
}
