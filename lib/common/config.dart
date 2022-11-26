class Config {
  /// 连接超时时间
  static const int connectTimeout = 8000;

  /// 请求超时时间
  static const int requestTimeout = 8000;

  /// baseURL
  static String getBaseUrl() {
    return "http://192.168.3.233:9999";
  }

  /// 请求日志输出
  static const bool logRequest = true;

  /// 默认contentType
  static const String defaultContentType = "application/json";
  // static const String defaultContentType = "application/x-www-form-urlencoded";
}
