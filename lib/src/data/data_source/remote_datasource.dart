import 'package:dio/dio.dart';
import 'package:flutter_credo/core/network/http_service_requester.dart';
import 'package:flutter_credo/src/data/models/init_payment_response_model.dart';

abstract class CredoRemoteDataSource {
  Future<InitPaymentResponse> initialPayment({
    required double amount,
    required String currency,
    String? redirectUrl,
    required String transactionRef,
    required String? paymentOptions,
    required String customerEmail,
    required String customerName,
    String? customerPhoneNo,
    required String publicKey,
  });
}

class CredoRemoteDataSourceImpl implements CredoRemoteDataSource {
  final HttpServiceRequester? httpServiceRequester;

  CredoRemoteDataSourceImpl(this.httpServiceRequester);

  @override
  Future<InitPaymentResponse> initialPayment({
    double? amount,
    String? currency,
    String? redirectUrl,
    String? transactionRef,
    String? paymentOptions,
    String? customerEmail,
    String? customerName,
    String? customerPhoneNo,
    required String publicKey,
  }) async {
    Map map = {
      "amount": amount,
      "currency": currency,
      "redirectUrl": redirectUrl ?? '',
      "transRef": transactionRef,
      "paymentOptions": paymentOptions,
      "customerEmail": customerEmail,
      "customerName": customerName,
      "customerPhoneNo": customerPhoneNo
    };
    final Response response = await httpServiceRequester!.post(
      endpoint: 'payments/initiate',
      body: map,
      secretKey: publicKey,
    );
    Map<String, dynamic> mapResponse = response.data is Map<String, dynamic>
        ? response.data
        : Map<String, dynamic>.from(response.data);
    mapResponse['transRef'] = transactionRef;
    return InitPaymentResponse.fromMap(mapResponse);
  }
}
