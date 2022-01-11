
/// Make payment using Credo's checkout form. The plugin will handle the whole
/// processes involved.
///
/// [context] - the widget's BuildContext
///
/// [charge] - the charge object.
///
/// [method] - The payment method to use(card, bank). It defaults to
/// [CheckoutMethod.selectable] to allow the user to select. For [CheckoutMethod.bank]
///  or [CheckoutMethod.selectable], it is
/// required that you supply an access code to the [Charge] object passed to [charge].
/// For [CheckoutMethod.card], though not recommended, passing a reference to the
/// [Charge] object will do just fine.
///
/// Notes:
///
/// * You can also pass the [PaymentCard] object and we'll use it to prepopulate the
/// card  fields if card payment is being used
///
/// [fullscreen] - Whether to display the payment in a full screen dialog or not
///
/// [logo] - The widget to display at the top left of the payment prompt.
/// Defaults to an Image widget with Credo's logo.
///
/// [hideEmail] - Whether to hide the email from the user. When
/// `false` and an email is passed to the [charge] object, the email
/// will be displayed at the top right edge of the UI prompt. Defaults to
/// `false`
///
/// [hideAmount]  - Whether to hide the user from the  payment prompt.
/// When `false` the payment amount and currency is displayed at the
/// top of payment prompt, just under the email. Also the payment
/// call-to-action will display the amount, otherwise it will display
/// "Continue". Defaults to `false`
//   static Future<CheckoutResponse> checkout(
//     BuildContext context, {
//     @required Charge charge,
//     CheckoutMethod method = CheckoutMethod.selectable,
//     bool fullscreen = false,
//     Widget logo,
//     bool hideEmail = false,
//     bool hideAmount = false,
//   }) async {
//     assert(context != null, 'context must not be null');
//     assert(
//         method != null,
//         'method must not be null. You can pass CheckoutMethod.selectable if you want '
//         'the user to select the checkout option');
//     assert(fullscreen != null, 'fullscreen must not be null');
//     assert(hideAmount != null, 'hideAmount must not be null');
//     assert(hideEmail != null, 'hideEmail must not be null');
//     return _Credo().checkout(
//       context,
//       charge: charge,
//       method: method,
//       fullscreen: fullscreen,
//       logo: logo,
//       hideAmount: hideAmount,
//       hideEmail: hideEmail,
//     );
//   }
// }

// // TODO: Remove beforeValidate, onSuccess, and onError in v1.1.0
// class _Credo {
//   Future<CheckoutResponse> chargeCard(
//       {@required BuildContext context,
//       @required Charge charge,
//       OnTransactionChange<Transaction> beforeValidate,
//       OnTransactionChange<Transaction> onSuccess,
//       OnTransactionError<Object, Transaction> onError}) {
//     final completer = Completer<CheckoutResponse>();
//     try {
//       final manager = new CardTransactionManager(
//           service: CardService(),
//           charge: charge,
//           context: context,
//           beforeValidate: (t) {
//             if (beforeValidate != null) beforeValidate(t);
//           },
//           onSuccess: (t) {
//             completer.complete(CheckoutResponse(
//                 message: t.message,
//                 reference: t.reference,
//                 status: true,
//                 card: charge.card..nullifyNumber(),
//                 method: CheckoutMethod.card,
//                 verify: true));

//             if (onSuccess != null) onSuccess(t);
//             t?.message;
//           },
//           onError: (o, t) {
//             completer.complete(CheckoutResponse(
//                 message: o.toString(),
//                 reference: t.reference,
//                 status: false,
//                 card: charge.card..nullifyNumber(),
//                 method: CheckoutMethod.card,
//                 verify: !(o is CredoException)));

//             if (onError != null) onError(o, t);
//           });

//       manager.chargeCard();
//     } catch (e) {
//       final message = e is CredoException ? e.message : Strings.sthWentWrong;
//       completer.complete(CheckoutResponse(
//           message: message,
//           reference: charge.reference,
//           status: false,
//           card: charge.card..nullifyNumber(),
//           method: CheckoutMethod.card,
//           verify: !(e is CredoException)));

//       if (onError != null) {
//         if (e is AuthenticationException) {
//           rethrow;
//         }
//         onError(e, null);
//       }
//     }
//     return completer.future;
//   }

//   Future<CheckoutResponse> checkout(
//     BuildContext context, {
//     @required Charge charge,
//     @required CheckoutMethod method,
//     @required bool fullscreen,
//     Widget logo,
//     bool hideEmail,
//     bool hideAmount,
//   }) async {
//     assert(() {
//       Utils.validateChargeAndKey(charge);
//       switch (method) {
//         case CheckoutMethod.card:
//           if (charge.accessCode == null && charge.reference == null) {
//             throw new ChargeException(Strings.noAccessCodeReference);
//           }
//           break;
//         case CheckoutMethod.bank:
//         case CheckoutMethod.selectable:
//           if (charge.accessCode == null) {
//             throw new ChargeException('Pass an accesscode');
//           }
//           break;
//       }
//       return true;
//     }());

//     CheckoutResponse response = await showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) => new CheckoutWidget(
//         bankService: BankService(),
//         cardsService: CardService(),
//         method: method,
//         charge: charge,
//         fullscreen: fullscreen,
//         logo: logo,
//         hideAmount: hideAmount,
//         hideEmail: hideEmail,
//       ),
//     );
//     return response == null ? CheckoutResponse.defaults() : response;
//   }
// }

// typedef void OnTransactionChange<Transaction>(Transaction transaction);
// typedef void OnTransactionError<Object, Transaction>(
//     Object e, Transaction transaction);

// enum CheckoutMethod { card, bank, selectable }
