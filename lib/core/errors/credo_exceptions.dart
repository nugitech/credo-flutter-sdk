class CredoException implements Exception {
  final String? message;
  CredoException({
    required this.message,
  });
}

class AuthenticationException extends CredoException {
  AuthenticationException(String message) : super(message: message);
}

class CardException extends CredoException {
  CardException(String message) : super(message: message);
}

class ChargeException extends CredoException {
  ChargeException(String message) : super(message: message);
}

class ExpiredAccessCodeException extends CredoException {
  ExpiredAccessCodeException(String message) : super(message: message);
}

class InvalidAmountException extends CredoException {
  int amount = 0;

  InvalidAmountException(this.amount)
      : super(
            message: '$amount is not a valid '
                'amount. only positive non-zero values are allowed.');
}

class InvalidEmailException extends CredoException {
  String email;

  InvalidEmailException(this.email)
      : super(message: '$email  is not a valid email');
}

class ProcessingException extends ChargeException {
  ProcessingException()
      : super(
          'A transaction is currently processing, please wait till it concludes before attempting a new charge.',
        );
}
