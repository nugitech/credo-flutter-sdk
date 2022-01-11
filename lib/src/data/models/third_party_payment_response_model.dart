import 'package:flutter_credo/src/data/models/api_response_model.dart';

class ThirdPartyPaymentResponse extends ApiResponseModel {
  String? transactionRef;

  Map<String, dynamic> toMap() {
    return {
      'transRef': transactionRef,
    };
  }

  ThirdPartyPaymentResponse.fromMap(Map<String, dynamic> map) {
    transactionRef = map['transRef'];
  }

  ThirdPartyPaymentResponse.fromErrorMap(Map<String, dynamic> map) {
    this.error = map['error'];
    this.status = map['status'];
    this.message = map['message'];
    this.path = map['path'];
  }

  @override
  String toString() =>
      'ThirdPartyPaymentResponse(transactionRef: $transactionRef, error: $error, status: $status, message:$message, path:$path)';
}
