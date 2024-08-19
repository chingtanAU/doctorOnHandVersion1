class FireError {
  static bool emailUsedError = false;
  static bool userNotFoundError = false;
  static bool wrongPassError = false;

  static void setEmailUseError(bool err) {
    emailUsedError = err;
  }

  static bool getEmailError() {
    return emailUsedError;
  }
}

String? nameValidator(String name) {
  return name.isNotEmpty ? null : 'Required';
}

String? emailValidator(String email) {
  // Regular expression for email validation
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

  if (email.isEmpty) {
    return "Email cannot be empty";
  } else if (FireError.getEmailError()) {
    return 'Email already in use';
  } else if (FireError.userNotFoundError) {
    return 'No user found for that email';
  } else if (!emailRegex.hasMatch(email)) {
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
