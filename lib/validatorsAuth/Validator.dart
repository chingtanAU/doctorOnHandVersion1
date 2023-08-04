import 'package:email_validator/email_validator.dart';

class FireError {
  static bool emailUsedError = false;
  static bool _userNotFoundError = false;
  static bool _wrongPassError = false;

  static bool get userNotFoundError => _userNotFoundError;
  static set userNotFoundError(bool value) {
    _userNotFoundError = value;
  }

  static bool get wrongPassError => _wrongPassError;
  static set wrongPassError(bool value) {
    _wrongPassError = value;
  }

  static void setEmailUseError(bool err) {
    emailUsedError = err;
  }

  static bool getEmailError() {
    return emailUsedError;
  }
}

String? nameValidator(String name) {
  return name.isNotEmpty ? null : 'Required ';
}

String? emailValidatro(String email) {
  if (email.isEmpty) {
    return "Email can not be empty";
  } else if (FireError.getEmailError()) {
    return 'Email already in use';
  } else if (FireError.userNotFoundError) {
    return 'No user found for that email';
  } else if (!EmailValidator.validate(email)) {
    return "Invalid Email Address";
  }
  return null;
}

String? passwordValidator(String value) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  if (value.isEmpty) {
    return 'Please enter password';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Enter valid password';
    } else if (FireError.wrongPassError) {
      return 'Wrong password provided for that user';
    } else {
      return null;
    }
  }
}

//validate phone number
String? phoneValidator(String value) {
  if (value.isEmpty) {
    return 'Please enter phone number';
  } else {
    if (value.length != 10) {
      return 'Enter valid phone number';
    } else {
      return null;
    }
  }
}
