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
      print(initial.toMap());
    } catch (e) {
      print(e);
      if (e is CredoException) {
        print(e.message);
      } else {
        print(e);
      }
    }
  }

  Future<void> makePayment() async {
    try {
      print('Make payment with credo');
      var res = await credoPlugin!.payWithWebUI(
        context: context,
        amount: 100.0,
        currency: 'NGN',
        customerEmail: 'jerryakem99@gmail.com',
        customerName: 'Jerry Akem',
        customerPhoneNo: '08132368804',
      );
      print(res);
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
      publicKey: 'pk_demo-Ghz9Wo4cGeebxzDwfNZdooKLFtX7op.cXgwh6MyBs-d',
    );
    makePayment();
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
