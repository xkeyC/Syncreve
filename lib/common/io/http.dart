import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:syncreve/common/account_manager.dart';
import 'package:syncreve/common/conf.dart';
import 'package:syncreve/data/http_result.dart';
import 'package:syncreve/base/base_utils.dart';

class AppHttp {
  static int httpRequestingCount = 0;

  static final Dio _dio =
      Dio(BaseOptions(connectTimeout: const Duration(seconds: 10)));

  static Dio get dio => _dio;

  /// [get]
  static Future<AppHttpResultData> get(String path,
      {Map<String, dynamic>? queryParameters,
      bool showLoading = false,
      bool throwError = true}) async {
    return await _doRequest("GET", path,
        queryParameters: queryParameters,
        showLoading: showLoading,
        throwError: throwError);
  }

  /// [put]
  static Future<AppHttpResultData> put(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      bool showLoading = false,
      bool showError = true}) async {
    return await _doRequest("PUT", path,
        data: data,
        queryParameters: queryParameters,
        showLoading: showLoading,
        throwError: showError);
  }

  /// [post]
  static Future<AppHttpResultData> post(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      bool showLoading = false,
      bool showError = true}) async {
    return await _doRequest("POST", path,
        data: data,
        queryParameters: queryParameters,
        showLoading: showLoading,
        throwError: showError);
  }

  static Future<AppHttpResultData> _doRequest(String method, String path,
      {data,
      Map<String, dynamic>? queryParameters,
      required bool showLoading,
      required bool throwError,
      bool firstError = true}) async {
    var url = path;
    if (!(url.startsWith("http://") || url.startsWith("https://"))) {
      url = "${AppAccountManager.workingAccount?.workingUrl}$path";
    }
    try {
      _onStartRequest(showLoading);

      final headers = await _getHeaders(url);
      dPrint(
          "[http.onRequest]($method $url),query==$queryParameters,data== $data,header == $headers");

      queryParameters?.removeWhere((key, value) => value == null);
      if (data is Map?) {
        data?.removeWhere((key, value) => value == null);
      }

      final resp = await _dio.request(url,
          options: Options(
            method: method,
            headers: headers,
          ),
          data: data,
          queryParameters: queryParameters);

      _onFinishRequest(showLoading);
      try {
        dPrint(
            "[http.onResponse]($method $path),data==${json.encode(resp.data)}");
      } catch (_) {}
      final resultData = AppHttpResultData.fromJson(resp.data);
      resultData.sourceStatusCode = resp.statusCode ?? -1;
      if (throwError && !resultData.isOK) {
        throw resultData;
      }
      return resultData;
    } catch (e) {
      dPrint("[http.onError]($method $path),error==$e");
      if (firstError &&
          AppAccountManager.workingAccount?.workingUrl !=
              AppAccountManager.workingAccount?.instanceUrl) {
        dPrint("[http] workingAccount.checkNewWorkingUrl");
        await AppAccountManager.workingAccount?.checkNewWorkingUrl();
        return _doRequest(method, path,
            showLoading: showLoading,
            throwError: throwError,
            firstError: false);
      }
      if (e is AppHttpResultData) {
        if (throwError) {
          rethrow;
        } else {
          return AppHttpResultData(code: -1, data: null, msg: e.msg);
        }
      } else {
        _onFinishRequest(showLoading);
        if (throwError) {
          rethrow;
        } else {
          return AppHttpResultData(code: -1, data: null, msg: e.toString());
        }
      }
    }
  }

  static Future<Map<String, dynamic>?> _getHeaders(String path) async {
    final Map<String, dynamic> headers = {
      "cookie": await AppAccountManager.getUrlCookie(path),
    };
    if (path.contains("/api/v3/site/config") && AppConf.tempSession != null) {
      headers["cookie"] = AppConf.tempSession;
    }
    headers.removeWhere((key, value) => value == null);
    return headers;
  }

  static void _onStartRequest(bool showLoading) {
    if (showLoading) {
      httpRequestingCount++;
      if (httpRequestingCount == 1) {
        EasyLoading.show();
      }
    }
  }

  static void _onFinishRequest(bool showLoading) {
    if (showLoading) {
      httpRequestingCount--;
      if (httpRequestingCount <= 0) {
        httpRequestingCount = 0;
        EasyLoading.dismiss();
      }
    }
  }
}
