import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(
      builder: (context) {
        return SizedBox(
          width: 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                color: Colors.red,
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Text('Loading....'),
              )
            ],
          ),
        );
      },
    ),
  );

  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_ALREADY_IN_USE":
      return "E=mail already use. Go to login page.";

    case "account-exists-with-differnce-credential":
      return "Email already use. Go to login page.";

    case "email-already-in-use":
      return "ERROR_WRONG_PASSWORD";

    case "wrong password":
      return "Wrong Password";

    case "ERROR_USER_NOT_FOUND":
      return "No user found with this email";

    case "user-not-found":
      return "No user found with this email";

    case "ERROR_USER_DISABLED":
      return "User disabled";

    case "ERROR_TOO_MANY_REQUEST":
      return "Too many requests to log into this account.";

    case "operation-not-allowed":
      return "Too many requests to log into this account.";

    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Too many requests to log into this account.";

    case "ERROR_INVALID_E-MAIL":
      return "Email address is invalid";

    case "invalid-email":
      return "Email address is invalid";

    default:
      return "Login failed. Please try again";
  }
}

bool loginValidation(String email, String password) {
  if (email.isEmpty && password.isEmpty) {
    showMessage("Both Fields are Empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email is Empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password is Empty");
    return false;
  } else {
    return true;
  }
}

bool signUpValidation(
    String email, String password, String name, String phone) {
  if (email.isEmpty && password.isEmpty && name.isEmpty && phone.isEmpty) {
    showMessage("All Fields are Empty");
    return false;
  } else if (name.isEmpty) {
    showMessage("Name is Empty");
    return false;
  } else if (email.isEmpty) {
    showMessage("Email is Empty");
    return false;
  } else if (phone.isEmpty) {
    showMessage("Phone is Empty");
    return false;
  } else if (password.isEmpty) {
    showMessage("Password is Empty");
    return false;
  } else {
    return true;
  }
}
