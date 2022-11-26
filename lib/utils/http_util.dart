import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
// import 'package:nearhub/utils/device_info_util.dart';
// import 'package:nearhub/utils/toast_util.dart';

import '../common/config.dart';
import 'c_log_util.dart';

/// 返回状态码
class HttpResponseCode {
  static const int successCode = 0;
  static const int errorCode = -1000;
  static const int logoutCode = 401;

  static const int connectTimeout = 6001;
  static const int receiveTimeout = 6002;
}

/// http请求方法
class HttpMethod {
  static const String get = "GET";
  static const String post = "POST";
  static const String put = "PUT";
  static const String delete = "DELETE";
  static const String option = "OPTION";
}

/// http请求contnettype
class HttpContentType {
  static const String form = "application/x-www-form-urlencoded";
  static const String formData = "multipart/form-data";
  static const String json = "application/json";
  static const String text = "text/xml";
}

/// 请求工具类
class HttpUtil {
  static proxyRequest(Dio dio, bool proxyOn, String ipString) {
    if (proxyOn) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
        client.findProxy = (uri) {
          // return "PROXY 192.168.1.113:8888";
          return "PROXY $ipString:8888";
        };
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  /// 获取请求头
  static Future<Map<String, dynamic>> getRequestHeader({
    String contentType = Config.defaultContentType,
  }) async {
    Map<String, dynamic> headers = {};

    // headers['os'] = await DeviceInfoUtil.getOs();
    // headers['app_version'] = await DeviceInfoUtil.getVersion();
    // headers['timestamp'] = DateTime.now().millisecondsSinceEpoch.toString();
    // headers['device'] = await DeviceInfoUtil.getDeivceName();
    // headers['app_store'] = DeviceInfoUtil.getChannelName();
    headers['Content-Type'] = contentType;
    // headers['mac'] = '';

    return headers;
  }

  /// 请求成功全局处理
  static Response onSuccess(Response? res) {
    Response successResponse =
        res ?? Response(statusCode: HttpResponseCode.errorCode, requestOptions: RequestOptions(path: ""));

    return successResponse;
  }

  /// 请求失败全局处理
  static Response onError(DioError error) {
    // 请求错误处理
    Response errorResponse =
        error.response ?? Response(statusCode: HttpResponseCode.errorCode, requestOptions: RequestOptions(path: ""));
    switch (error.type) {
      case DioErrorType.connectTimeout: // 请求超时
        errorResponse.statusCode = HttpResponseCode.connectTimeout;
        errorResponse.statusMessage = "网络连接超时，请检查网络";
        break;
      case DioErrorType.receiveTimeout: // 请求连接超时
        errorResponse.statusCode = HttpResponseCode.receiveTimeout;
        errorResponse.statusMessage = "网络请求超时，请稍后重试";
        break;
      case DioErrorType.response: // 服务器内部错误
        errorResponse.statusCode = error.response?.statusCode;
        errorResponse.statusMessage = "服务器繁忙，请稍后重试";
        break;
      case DioErrorType.cancel: // 请求取消
        errorResponse.statusCode = error.response?.statusCode;
        errorResponse.statusMessage = "请求取消";
        break;
      case DioErrorType.other: // 其他错误
        errorResponse.statusCode = error.response?.statusCode;
        errorResponse.statusMessage = "网络错误，请稍后重试";
        break;
      default:
    }
    LOG.d('${errorResponse.statusMessage ?? ""}======================错误信息');

    /// 添加错误提示
    // ToastUtil.error(errorResponse.statusMessage ?? "");

    /// 返回错误
    return errorResponse;
  }
}
