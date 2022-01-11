import 'package:dio/dio.dart';
import 'package:flutter_credo/core/network/http_service_requester.dart';
import 'package:flutter_credo/src/data/models/init_payment_response_model.dart';
import 'package:flutter_credo/src/data/models/third_party_payment_response_model.dart';
import 'package:flutter_credo/src/data/models/verify_card_response_model.dart';
import 'package:flutter_credo/src/data/models/verify_transaction_response.dart';

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

  Future<VerifyTransactionResponse> verifyTransaction({
    required String transactionRef,
    required String secretKey,
  });

  Future<ThirdPartyPaymentResponse> thirdPartyPay({
    required String orderCurrency,
    required String cardNumber,
    required String expiryMonth,
    required String expiryYear,
    required String securityCode,
    required String transRef,
    required String? customerEmail,
    required String? customerName,
    required String? customerPhoneNo,
    required String? paymentSlug,
    required double? orderAmount,
    required String secretKey,
  });

  Future<VerifyCardResponse> verifyCardDetails({
    required String cardNumber,
    required String orderCurrency,
    required String? paymentSlug,
    required String secretKey,
  });

  Future<ThirdPartyPaymentResponse> payThreeDs({
    required double amount,
    required String currency,
    required String transRef,
    required String customerEmail,
    required String customerName,
    required String customerPhoneNo,
    required String redirectUrl,
    required String paymentOptions,
    required String secretKey,
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

  @override
  Future<ThirdPartyPaymentResponse> payThreeDs({
    double? amount,
    String? currency,
    String? transRef,
    String? customerEmail,
    String? customerName,
    String? customerPhoneNo,
    String? redirectUrl,
    String? paymentOptions,
    required String secretKey,
  }) async {
    Map map = {
      "amount": amount,
      "currency": currency,
      "redirectUrl": redirectUrl,
      "transRef": transRef,
      "paymentOptions": paymentOptions,
      "customerEmail": customerEmail,
      "customerName": customerName,
      "customerPhoneNo": customerPhoneNo,
    };
    final Response response = await httpServiceRequester!.post(
      endpoint: 'payments/card/third-party/3ds-pay',
      body: map,
      secretKey: secretKey,
    );
    return ThirdPartyPaymentResponse.fromMap(
      response.data is Map<String, dynamic>
          ? response.data
          : Map<String, dynamic>.from(response.data),
    );
  }

  @override
  Future<ThirdPartyPaymentResponse> thirdPartyPay({
    String? orderCurrency,
    String? cardNumber,
    String? expiryMonth,
    String? expiryYear,
    String? securityCode,
    String? transRef,
    String? customerEmail,
    String? customerName,
    String? customerPhoneNo,
    String? paymentSlug,
    required String secretKey,
    double? orderAmount,
  }) async {
    Map map = {
      "orderAmount": orderAmount,
      "orderCurrency": orderCurrency,
      "cardNumber": cardNumber,
      "expiryMonth": expiryMonth,
      "expiryYear": expiryYear,
      "securityCode": securityCode,
      "transRef": transRef,
      "customerEmail": customerEmail,
      "customerName": customerName,
      "customerPhoneNo": customerPhoneNo,
      "paymentSlug": paymentSlug,
    };
    final Response response = await httpServiceRequester!.post(
      endpoint: 'payments/card/third-party/pay',
      body: map,
      secretKey: secretKey,
    );
    return ThirdPartyPaymentResponse.fromMap(
      response.data is Map<String, dynamic>
          ? response.data
          : Map<String, dynamic>.from(response.data),
    );
  }

  @override
  Future<VerifyCardResponse> verifyCardDetails({
    required String cardNumber,
    required String orderCurrency,
    String? paymentSlug,
    required String secretKey,
  }) async {
    Map map = {
      "cardNumber": cardNumber,
      "orderCurrency": orderCurrency,
      "paymentSlug": paymentSlug,
    };

    final Response response = await httpServiceRequester!.post(
      endpoint: 'payments/card/third-party/3ds-verify-card-number',
      body: map,
      secretKey: secretKey,
    );

    return VerifyCardResponse.fromMap(
      response.data is Map<String, dynamic>
          ? response.data
          : Map<String, dynamic>.from(response.data),
    );
  }

  @override
  Future<VerifyTransactionResponse> verifyTransaction({
    required String transactionRef,
    required String secretKey,
  }) async {
    final Response response = await httpServiceRequester!.getRequest(
      endpoint: 'transactions/$transactionRef/verify',
      queryParam: {},
      secretKey: secretKey,
    );
    return VerifyTransactionResponse.fromMap(
      response.data is Map<String, dynamic>
          ? response.data
          : Map<String, dynamic>.from(response.data),
    );
  }
}
