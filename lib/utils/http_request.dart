import 'package:dio/dio.dart';

import '../common/config.dart';
import 'c_log_util.dart';
import 'custom_interceptor.dart';
import 'http_util.dart';

class HttpRequest {
  static late HttpRequest _instance;
  static bool _isInstanceCreated = false;
  static Dio? _dio;

  factory HttpRequest() => getInstance();
  static HttpRequest get instance => getInstance();
  static HttpRequest getInstance() {
    if (_isInstanceCreated == false) {
      _instance = HttpRequest._internal();
    }
    _isInstanceCreated = true;
    return _instance;
  }

  HttpRequest._internal() {
    if (_isInstanceCreated == false) {
      var options = BaseOptions(
        baseUrl: Config.getBaseUrl(),
        connectTimeout: Config.connectTimeout,
        receiveTimeout: Config.requestTimeout,
      );
      _dio = Dio(options);

      /// 加载拦截器
      _dio?.interceptors.add(CustomInterceptor());
    }
  }

  /// get请求
  Future<Response> get(
    String path, {
    Map<String, dynamic>? params,
    bool? loading = false,
    String? contentType = Config.defaultContentType,
    Map<String, dynamic>? headers,
    Function(Response res)? onSuccess,
    Function(Response errRes)? onError,
  }) async {
    return request(path, HttpMethod.get,
        params: params,
        loading: loading,
        contentType: contentType,
        onError: onError,
        headers: headers,
        onSuccess: onSuccess);
  }

  /// post请求
  Future<Response> post(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
    bool? loading = false,
    Map<String, dynamic>? headers,
    String? contentType = Config.defaultContentType,
    Function(Response res)? onSuccess,
    Function(Response errRes)? onError,
  }) async {
    return request(path, HttpMethod.post,
        params: params,
        data: data,
        loading: loading,
        contentType: contentType,
        headers: headers,
        onError: onError,
        onSuccess: onSuccess);
  }

  /// put请求
  Future<Response> put(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
    bool? loading = false,
    String? contentType = Config.defaultContentType,
    Function(Response res)? onSuccess,
    Function(Response errRes)? onError,
  }) async {
    return request(path, HttpMethod.put,
        params: params, data: data, loading: loading, contentType: contentType, onError: onError, onSuccess: onSuccess);
  }

  /// delete请求
  Future<Response> delete(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
    bool? loading = false,
    String? contentType = Config.defaultContentType,
    Function(Response res)? onSuccess,
    Function(Response errRes)? onError,
  }) async {
    return request(path, HttpMethod.delete,
        params: params, data: data, loading: loading, contentType: contentType, onError: onError, onSuccess: onSuccess);
  }

  /// option请求
  Future<Response> option(
    String path, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
    bool? loading = false,
    String? contentType = Config.defaultContentType,
    Function(Response res)? onSuccess,
    Function(Response errRes)? onError,
  }) async {
    return request(path, HttpMethod.option,
        params: params, loading: loading, contentType: contentType, onError: onError, onSuccess: onSuccess);
  }

  Future<Response> request(
    String path,
    String method, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    String? contentType = Config.defaultContentType,
    Map<String, dynamic>? headers,
    bool? loading = false,
    Function(Response res)? onSuccess,
    Function(Response errRes)? onError,
  }) async {
    _dio!.options.method = method;
    _dio!.options.headers['content-type'] = contentType;
    _dio!.options.headers = {..._dio!.options.headers, ...?headers};

    Response response =
        Response(statusCode: HttpResponseCode.errorCode, requestOptions: RequestOptions(path: path, headers: headers));
    if (loading == true) {
      // ToastUtil.show();
      // 提示
    }

    try {
      response = await _dio?.request(
            path,
            queryParameters: params,
            data: data,
          ) ??
          response;
      onSuccess?.call(response);
    } catch (e) {
      DioError err = DioError(
        requestOptions: RequestOptions(path: path, method: method, queryParameters: params, data: data),
        response: (e as DioError).response,
        type: DioErrorType.response,
      );
      // if (e is DioError) {
      //   err.type = e.type;
      // }
      response.statusCode = err.response?.statusCode;
      response.data = err.response?.data;
      response.statusMessage = err.message;
      // LOG.d('--------------${e.error == 'Http status error [401]'}');
      onError?.call(response);
    }
    // 提示
    // ToastUtil.dismiss();

    return response;
  }
}
