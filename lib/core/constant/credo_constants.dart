import 'dart:io';

mixin CredoConstants {
  final Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  final String baseUrl = 'https://api.credocentral.com/credo-payment/v1/';
}
