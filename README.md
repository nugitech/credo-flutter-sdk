# flutter-credo-sdk

## Credo SDK Flutter

This library allows for the easy integration of [Credo] into your Flutter application. It shoulders the burden of PCI compliance by sending credit card details directly to Credo's servers rather than to your server.

## Flow Summary

1. Collect user's card details, email and phone number. 
	
2. Initialize the CredoPlugin by creating an object of the CredoPlugin class with two named parameters passed to the constructor.
	- The first argument is the public key of the merchant
	- The second argument is the secret key of the merchant.
	- Both public and secret keys are provided by Credo to the merchants.
	-  Prompts backend to initialize transactions by calling the `initialPayment` method.
	- Credo's backend returns a `payment slug` which is returned when `Initiate Payment` endpoint is called
	- App provides the `payment slug` and card details to our SDK's using the `pay` and `verifyCardNumber` methods
	
3. Once request is successful,  `ThirdPartyPaymentResponse` is return.


## Installation
- To start using this package, simply add the following to project `pubspec.yaml`

```
  flutter_credo: <lastes-version>
```

## Usage

### 1. Permissions
To use this package, your android app must declare internet permission. Add the following code to the application level of your AndroidManifest.xml.

```xml
	<uses-permission android:name="android.permission.INTERNET" />
```

### 2. Initializing SDK
	To use [Credo] SDK, you need to first initialize it by using the `CredoPlugin` class.
	
```dart

CredoPlugin credoPlugin =  CredoPlugin(
    publicKey:  'public_key',
    secretKey:  'secret_key',
);

```
Ensure to perform this instantiation in the `initState` method of your Widget.

```dart
CredoPlugin credoPlugin;

@override
void  initState() {
credoPlugin =  CredoPlugin(
publicKey:  'pk_demo-cKwtbsYaPNjgZZIFfznnZJGP49plbw.ujlZ0XcwAD-d',
secretKey:  'sk_demo-dQJJE9tFlunJv9jjZmJ49nyhqXKrbA.CchUPg1aqj-d',
);

initPayment();
super.initState();
}
```

### 3. Initiate Payment
Payment transaction can be initiated with the `initialPayment` method: 
## Parameters
- `amount` The amount to be transacted.
- `currency` The currency to be transacted in. 
- `redirectUrl` The url to redirect to after transaction.
- `transRef` [optional] The transaction reference for the payment
- `paymentOptions` option can be "CARD" or "USSD" or "BANK"
- `customerName` Name of the customer
- `customerEmail` Email address of the customer
- `customerPhone` Phone number of the customer
If the method call is success a `InitPaymentResponse` is returned from the `Future` else it throws a `CredoException` with an error message.
	
```dart
	.
	.
	.
	try{
		InitPaymentResponse initPaymentRes =  await credoPlugin.initialPayment(
		amount:  100.0,
		currency:  'NGN',
		customerEmail:  'info@charlesarchibong.com',
		customerName:  'Charles Archibong',
		customerPhoneNo:  '000000000000',
		);
	}catch(e){
		if(e is CredoException){
			print(e.message);
		}
	}
```

### 5. Make Payment

After payment initialization, payment is made using the `pay` method
	
## Parameters
- `amount` The amount to be transacted.   
- `ordeCurrency` The currency to be transacted in. 
- `cardNumber` The number of the verified debit card.
- `expiryMonth` The expiry month of the verified card.
- `expiryYear` The expiry Year of the verified card.
- `securityCode` The cvv number of the verified card.
- `transRef` The transaction reference used to during initiate payment stage.
- `customerEmail` Email address of the customer.
- `customerName` Name of the customer.
- `customerPhone` Phone number of the customer.
- `paymentSlug` this is part of the response of `initiatePayment` method in step 3 above.

```dart
	...
	try{
		ThirdPartyPaymentResponse thirdPartyPaymentResponse = await credoPlugin.pay(
			orderCurrency:  'NGN',
			cardNumber:  '',
			expiryMonth:  '07',
			expiryYear:  '23',
			securityCode:  '027',
			transRef:  initPaymentRes.transactionRef,
			paymentSlug: initPaymentRes.paymentSlug,
			orderAmount:  100.00,
			customerEmail:  'charlesarchibong10@gmail.com',
			customerName:  'Charles Archibong',
			customerPhoneNo:  '09039311559',
		);
	} catch(e){
		if(e is CredoException){
			print(e.message);
		}
	}
```

After payment, you can call the `verifyTransaction` which returns `VerifyTransactionResponse` to verify the payment and confirm all is good. 

you can check out the example on [this link](https://github.com/charlesarchibong/flutter_credo/tree/dev/example)
	


# Author
- [Charles Archibong](https://www.linkedin.com/in/charles-archibong-9b6a23164/)



	
