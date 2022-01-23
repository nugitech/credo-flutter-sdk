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
          child: Column(
            children: [
              Expanded(
                child: WebView(
                  initialUrl: widget.paymentLink,
                  javascriptMode: JavascriptMode.unrestricted,
                  backgroundColor: Colors.transparent,
                  navigationDelegate: (NavigationRequest request) {
                    return NavigationDecision.navigate;
                  },
                  gestureNavigationEnabled: true,
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0XFF0644cc),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
