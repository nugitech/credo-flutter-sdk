import 'package:dio/dio.dart';
import 'package:flutter_credo/core/network/http_service_requester.dart';
import 'package:flutter_credo/src/data/data_source/remote_datasource.dart';
import 'package:flutter_credo/src/data/models/init_payment_response_model.dart';
import 'package:flutter_credo/src/data/models/third_party_payment_response_model.dart';
import 'package:flutter_credo/src/data/models/verify_card_response_model.dart';
import 'package:flutter_credo/src/data/models/verify_transaction_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockHttpServiceRequester extends Mock implements HttpServiceRequester {}

main() {
  MockHttpServiceRequester? mockHttpServiceRequester;
  late CredoRemoteDataSourceImpl credoRemoteDataSourceImpl;
  setUp(() {
    mockHttpServiceRequester = MockHttpServiceRequester();
    credoRemoteDataSourceImpl =
        CredoRemoteDataSourceImpl(mockHttpServiceRequester);
  });

  group('$CredoRemoteDataSourceImpl', () {
    group('InitPayment', () {
      test(
          'should return valid API response ($InitPaymentResponse) when the response status is = 200',
          () async {
        Map map = {
          "amount": 200.00,
          "currency": 'NGN',
          "redirectUrl": 'https://charlesarchibong.com',
          "transRef": '1243',
          "paymentOptions": 'CARD',
          "customerEmail": 'info@charlesarchibong.com',
          "customerName": 'Charles Archibong',
          "customerPhoneNo": '09039311229',
        };
        when(
          mockHttpServiceRequester!.post(
            endpoint: 'payments/initiate',
            body: map,
            secretKey: 'xxxxxxxx',
          ),
        ).thenAnswer(
          (_) async => Response(
            data: {'paymentLink': 'https://charlesarchibong.com'},
            statusCode: 200,
            requestOptions: RequestOptions(path: '/payments/initiate'),
          ),
        );

        InitPaymentResponse initPaymentResponseModel =
            await credoRemoteDataSourceImpl.initialPayment(
          amount: 200.00,
          currency: 'NGN',
          customerEmail: 'info@charlesarchibong.com',
          customerName: 'Charles Archibong',
          customerPhoneNo: '09039311229',
          paymentOptions: 'CARD',
          redirectUrl: 'https://charlesarchibong.com',
          transactionRef: '1243',
          publicKey: 'xxxxxxxx',
        );

        expect(
          initPaymentResponseModel.toMap(),
          equals(
            {
              'paymentLink': 'https://charlesarchibong.com',
              'paymentSlug': null,
              'transRef': '1243'
            },
          ),
        );
      });
    });

    group('PayThreeDS', () {
      test(
          'should return valid API response ($ThirdPartyPaymentResponse) when the response status is = 200',
          () async {
        Map map = {
          "amount": 1500.3,
          "currency": "NGN",
          "redirectUrl": "http://charles",
          "transRef": "iy67f64hvc63",
          "paymentOptions": "CARD,BANK",
          "customerEmail": "cicirochwukunle@example.com",
          "customerName": "Ciroma Chukwuma Adekunle",
          "customerPhoneNo": "2348012345678"
        };
        when(
          mockHttpServiceRequester!.post(
            endpoint: 'payments/card/third-party/3ds-pay',
            body: map,
            secretKey: 'xxxxxxxxxxxxx',
          ),
        ).thenAnswer(
          (_) async => Response(
            data: {"transRef": "iy67f64hvc63"},
            statusCode: 200,
            requestOptions:
                RequestOptions(path: '/payments/card/third-party/3ds-pay'),
          ),
        );

        ThirdPartyPaymentResponse thirdPartyPaymentResponse =
            await credoRemoteDataSourceImpl.payThreeDs(
          amount: 1500.3,
          currency: 'NGN',
          customerEmail: 'cicirochwukunle@example.com',
          customerName: 'Ciroma Chukwuma Adekunle',
          customerPhoneNo: '2348012345678',
          paymentOptions: 'CARD,BANK',
          transRef: "iy67f64hvc63",
          redirectUrl: "http://charles",
          secretKey: 'xxxxxxxxxxxxx',
        );

        expect(
          thirdPartyPaymentResponse.toMap(),
          equals({"transRef": "iy67f64hvc63"}),
        );
      });
    });

    group('PayWithCard', () {
      test(
          'should return valid API response ($ThirdPartyPaymentResponse) when the response status is = 200',
          () async {
        Map map = {
          "orderAmount": 5000,
          "orderCurrency": "NGN",
          "cardNumber": "5399670123490229",
          "expiryMonth": "05",
          "expiryYear": "22",
          "securityCode": "439",
          "transRef": "iy67f64hvc63",
          "customerEmail": "chunkylover53@aol.com",
          "customerName": "King of Kings",
          "customerPhoneNo": "+2348066282658",
          "paymentSlug": "0H0UOEsawNjkIxgspANd"
        };
        when(
          mockHttpServiceRequester!.post(
            endpoint: 'payments/card/third-party/pay',
            body: map,
            secretKey: 'xxxxxxxxxxxxx',
          ),
        ).thenAnswer(
          (_) async => Response(
            data: {"transRef": "iy67f64hvc63"},
            statusCode: 200,
            requestOptions:
                RequestOptions(path: '/payments/card/third-party/pay'),
          ),
        );

        ThirdPartyPaymentResponse thirdPartyPaymentResponse =
            await credoRemoteDataSourceImpl.thirdPartyPay(
          secretKey: "xxxxxxxxxxxxx",
          cardNumber: "5399670123490229",
          customerEmail: "chunkylover53@aol.com",
          customerName: "King of Kings",
          customerPhoneNo: "+2348066282658",
          expiryMonth: "05",
          expiryYear: "22",
          securityCode: "439",
          orderAmount: 5000,
          orderCurrency: "NGN",
          paymentSlug: "0H0UOEsawNjkIxgspANd",
          transRef: 'iy67f64hvc63',
        );

        expect(
          thirdPartyPaymentResponse.toMap(),
          equals({"transRef": "iy67f64hvc63"}),
        );
      });
    });

    group('VerifyCardDetails', () {
      test(
          'should return valid API response ($VerifyCardResponse) when the response status is = 200',
          () async {
        Map map = {
          "cardNumber": "4242424242424242",
          "orderCurrency": "NGN",
          "paymentSlug": "0H0UOEsawNjkIxgspANd"
        };
        when(
          mockHttpServiceRequester!.post(
            endpoint: 'payments/card/third-party/3ds-verify-card-number',
            body: map,
            secretKey: 'xxxxxxxxxxxxx',
          ),
        ).thenReturn(
          Future.value(
            Response(
              data: {
                "orderId": "order-5reYwpe",
                "transactionId": "8881038237uwe",
                "gatewayCode": "string",
                "gatewayRecommendation": "string",
                "correlationId": "string",
                "timeOfRecord": "string",
                "redirectHtml": "string"
              },
              statusCode: 200,
              requestOptions: RequestOptions(
                  path: 'payments/card/third-party/3ds-verify-card-number'),
            ),
          ),
        );

        VerifyCardResponse verifyCardResponseModel =
            await credoRemoteDataSourceImpl.verifyCardDetails(
          secretKey: "xxxxxxxxxxxxx",
          cardNumber: "4242424242424242",
          orderCurrency: "NGN",
          paymentSlug: "0H0UOEsawNjkIxgspANd",
        );

        expect(
          verifyCardResponseModel.toMap(),
          equals({
            "orderId": "order-5reYwpe",
            "transactionId": "8881038237uwe",
            "gatewayCode": "string",
            "gatewayRecommendation": "string",
            "correlationId": "string",
            "timeOfRecord": "string",
            "redirectHtml": "string"
          }),
        );
      });
    });

    group('VerifyTransaction', () {
      test(
          'should return valid API response ($VerifyTransactionResponse) when the response status is = 200',
          () async {
        Map map = {
          "id": 4,
          "completedAt": "2021-01-28T12:35:43",
          "createdAt": "2021-01-28T12:35:43",
          "customerEmail": "cirochwukunle@example.com",
          "customerName": "Ciroma Chukwuma Adekunle",
          "customerPhoneNo": "2348012345678",
          "customerUuid": null,
          "date": "2021-01-28",
          "description": "Transaction",
          "dueAmount": 100,
          "merchantImsId": 154789685478965,
          "merchantReferenceNo": "254655-4946-3634",
          "processingFees": "1.5,",
          "customerCharge": "0.0,",
          "referenceNo": "order-URQiaJZRvd",
          "totalAmount": 101.5,
          "updatedAt": "2021-01-28T12:35:43",
          "approvalStatus": {"name": "Accepted"},
          "paymentChannel": {"name": "Card"},
          "paymentStatus": {"name": "Successful"},
          "paymentOption": {"name": "Regular"}
        };
        when(
          mockHttpServiceRequester!.getRequest(
            endpoint: 'transactions/xxxxx124/verify',
            queryParam: {},
            secretKey: 'secretKey',
          ),
        ).thenAnswer(
          (_) async => Response(
              data: map,
              statusCode: 200,
              requestOptions:
                  RequestOptions(path: '/transactions/xxxxx124/verify')),
        );

        VerifyTransactionResponse verifyTransactionResponseModel =
            await credoRemoteDataSourceImpl.verifyTransaction(
          secretKey: 'secretKey',
          transactionRef: "xxxxx124",
        );

        expect(
          verifyTransactionResponseModel.toMap(),
          equals(map),
        );
      });
    });
  });
}
