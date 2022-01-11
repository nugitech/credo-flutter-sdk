import 'package:dio/dio.dart';
import 'package:flutter_credo/core/constant/credo_constants.dart';

class HttpServiceRequester with CredoConstants {
  late Dio dio;

  HttpServiceRequester() {
    this.dio = Dio();
  }

  Future<Response> post({
    required String endpoint,
    String? secretKey,
    dynamic body,
    Map? queryParam,
  }) async {
    dio.options.headers = headers;
    dio.options.headers["Authorization"] = "$secretKey";
    Response response = await dio.post(
      baseUrl + endpoint,
      data: body,
      queryParameters: queryParam as Map<String, dynamic>?,
    );
    return response;
  }

  Future<dynamic> getRequest({
    required String endpoint,
    required String secretKey,
    required Map queryParam,
  }) async {
    dio.options.headers = headers;
    dio.options.headers["Authorization"] = "$secretKey";

    Response response = await dio.get(
      baseUrl + endpoint,
    );
    return response;
  }
}
