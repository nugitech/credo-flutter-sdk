import 'package:flutter_credo/src/data/models/api_response_model.dart';

class VerifyCardResponse extends ApiResponseModel {
  String? orderId;
  String? transactionId;
  String? gatewayCode;
  String? gatewayRecommendation;
  String? correlationId;
  String? timeOfRecord;
  String? redirectionHtml;

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'transactionId': transactionId,
      'gatewayCode': gatewayCode,
      'gatewayRecommendation': gatewayRecommendation,
      'correlationId': correlationId,
      'timeOfRecord': timeOfRecord,
      'redirectHtml': redirectionHtml,
    };
  }

  VerifyCardResponse.fromMap(Map<String, dynamic> map) {
    orderId = map['orderId'];
    transactionId = map['transactionId'];
    gatewayCode = map['gatewayCode'];
    gatewayRecommendation = map['gatewayRecommendation'];
    correlationId = map['correlationId'];
    timeOfRecord = map['timeOfRecord'];
    redirectionHtml = map['redirectHtml'];
  }

  VerifyCardResponse.fromErrorMap(Map<String, dynamic> map) {
    this.error = map['error'];
    this.status = map['status'];
    this.message = map['message'];
    this.path = map['path'];
  }

  @override
  String toString() {
    return 'VerifyCardResponse(orderId: $orderId, transactionId: $transactionId, gatewayCode: $gatewayCode, gatewayRecommendation: $gatewayRecommendation, correlationId: $correlationId, timeOfRecord: $timeOfRecord, redirectionHtml: $redirectionHtml, error: $error, status: $status, message:$message, path:$path)';
  }
}
