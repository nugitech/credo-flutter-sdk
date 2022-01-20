// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_credo/core/extensions/screen_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebview extends StatefulWidget {
  final String paymentLink;
  const PaymentWebview({Key? key, required this.paymentLink}) : super(key: key);

  @override
  State<PaymentWebview> createState() => _PaymentWebviewState();
}

class _PaymentWebviewState extends State<PaymentWebview> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: context.screenWidth() - 40,
          height: context.screenHeight(0.75),
          child: WebView(
            initialUrl: widget.paymentLink,
            javascriptMode: JavascriptMode.unrestricted,
            backgroundColor: Colors.transparent,
            navigationDelegate: (NavigationRequest request) {
              print(request.url);
              if (request.url.startsWith('https://www.youtube.com/')) {
                print('blocking navigation to $request}');
                Navigator.pop(context, true);
                // return NavigationDecision.prevent;
              }
              print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            gestureNavigationEnabled: true,
          ),
        ),
      ),
    );
  }
}
