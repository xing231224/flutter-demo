import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/utils/c_log_util.dart';

import '../common/config.dart';
import 'http_util.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    /// 加载请求头
    // Map<String, dynamic> headers = await HttpUtil.getRequestHeader();
    // options.headers = headers;

    if (Config.logRequest) {
      LOG.d('');
      LOG.d('[=========== ${options.path} ==========]');
      LOG.d('[ URL    ]：${options.baseUrl + options.path}');
      LOG.d('[ OPTIONS    ]：${options.baseUrl + options.path}');
      LOG.d('[ METHOD ]：${options.method}');
      LOG.d('[ HEADER ]：${json.encode(options.headers)}');
      LOG.d('[ PARAMS ]：${json.encode(options.queryParameters)}');
      LOG.d('[ DATAS  ]：${json.encode(options.data)}');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    /// 可以在此处处理加密

    if (Config.logRequest) {
      LOG.d('[ SUCCESS ]');
      LOG.d('[ RESULT  ]：${json.encode(response.data)}');
      LOG.d('[========================================]');
      LOG.d('');
    }

    /// 公共处理成功请求
    HttpUtil.onSuccess(response);

    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (Config.logRequest) {
      LOG.d('[ *ERROR* ]');
      LOG.d('[ ERROR  ]：${err.response}');
      LOG.d('[========================================]');
      LOG.d('');
    }

    /// 公共处理失败请求
    HttpUtil.onError(err);
    handler.next(err);
  }
}
