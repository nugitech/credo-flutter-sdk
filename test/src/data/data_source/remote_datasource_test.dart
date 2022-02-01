import 'package:dio/dio.dart';
import 'package:flutter_credo/core/network/http_service_requester.dart';
import 'package:flutter_credo/src/data/data_source/remote_datasource.dart';
import 'package:flutter_credo/src/data/models/init_payment_response_model.dart';
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
            publicKey: 'xxxxxxxx',
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
  });
}
