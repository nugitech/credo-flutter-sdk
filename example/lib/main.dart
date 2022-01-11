import 'package:flutter/material.dart';
import 'package:flutter_credo/flutter_credo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credo Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CredoPlugin? credoPlugin;

  Future<void> initPayment() async {
    try {
      print('Initial payment with credo');
      InitPaymentResponse initial = await credoPlugin!.initialPayment(
        amount: 100.0,
        currency: 'NGN',
        customerEmail: 'charlesarchibong10@gmail.com',
        customerName: 'Charles Archibong',
        customerPhoneNo: '09039311559',
      );

      //Get payment slug from initial payment and use it to pay
      print(initial.toMap());
      ThirdPartyPaymentResponse thirdPartyPaymentResponse =
          await credoPlugin!.pay(
        orderCurrency: 'NGN',
        cardNumber: '',
        expiryMonth: '07',
        expiryYear: '23',
        securityCode: '027',
        transRef: 'teajenqfjehw',
        paymentSlug: initial.paymentSlug,
        orderAmount: 100.00,
        customerEmail: 'charlesarchibong10@gmail.com',
        customerName: 'Charles Archibong',
        customerPhoneNo: '09039311559',
      );
      print(thirdPartyPaymentResponse.toMap());
    } catch (e) {
      print(e);
      if (e is CredoException) {
        print(e.message);
      } else {
        print(e);
      }
    }
  }

  @override
  void initState() {
    credoPlugin = CredoPlugin(
      publicKey: 'pk_demo-cKwtbsYaPNjgZZIFfznnZJGP49plbw.ujlZ0XcwAD-d',
      secretKey: 'sk_demo-dQJJE9tFlunJv9jjZmJ49nyhqXKrbA.CchUPg1aqj-d',
    );
    initPayment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your payment slug :',
            ),
            Text(
              '...',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
