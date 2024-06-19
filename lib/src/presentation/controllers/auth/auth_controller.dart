import 'package:cripto_wacher/src/core/utils/validate_email.dart';
import 'package:cripto_wacher/src/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthController with ChangeNotifier {
  // list of users registered
  List<User> users = [];

  // controller for text fields to sing up

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  // controller for text fields to sign in

  TextEditingController emailSignInController = TextEditingController();

  TextEditingController passwordSignInController = TextEditingController();

  // error message fields
  String? errorEmailText;
  String? errorPasswordText;

  // error sign in message
  String? errorSignIn;

  // validation methods
  bool emailValidation(String value) {
    if (!validateEmail(value)) {
      errorEmailText = 'Email is not valid';
      notifyListeners();
      return false;
    } else {
      errorEmailText = null;
      notifyListeners();
      return true;
    }
  }

  bool passwordValidation() {
    if (passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      if (passwordController.text != confirmPasswordController.text) {
        errorPasswordText = 'The passwords dont match';
        notifyListeners();
        return false;
      } else {
        errorPasswordText = null;
        notifyListeners();
        return true;
      }
    } else {
      errorPasswordText = 'The password cannot be empty';
      notifyListeners();
      return false;
    }
  }

  bool passwordSignInValidation() {
    if (passwordSignInController.text.isEmpty) {
      errorPasswordText = "The password cannot be empty";
      notifyListeners();
      return false;
    } else {
      errorPasswordText = null;
      notifyListeners();
      return true;
    }
  }

  bool verifyCredentials() {
    return (emailController.text == emailSignInController.text) &&
        (passwordController.text == passwordSignInController.text);
  }

  bool userExist() {
    User? user;
    try {
      user = users.firstWhere((element) =>
          (element.email == emailSignInController.text) &&
          (element.password == passwordSignInController.text));
    } catch (e) {
      user = null;
    }
    print(user != null);
    return user != null;
  }

  // handle sign in
  void handleSignIn(BuildContext context) {
    bool emailValid = emailValidation(emailSignInController.text);
    bool passwordValid = passwordSignInValidation();

    if (emailValid && passwordValid) {
      bool user = userExist();
      if (user) {
        errorSignIn = null;
        clearTextFieldControllers();
        notifyListeners();
        context.go('/home');
      } else {
        errorSignIn = 'The user is not registered';
        notifyListeners();
      }
    }
  }

  // handle sign up method
  void handleSignUp(BuildContext context) async {
    bool emailValid = emailValidation(emailController.text);
    bool passwordValid = passwordValidation();

    if (emailValid && passwordValid) {
      users.add(
          User(email: emailController.text, password: passwordController.text));
      clearTextFieldControllers();
      context.go('/home');
    }
  }

  // clear all text fields controllers
  void clearTextFieldControllers() {
    emailSignInController.text = '';
    emailController.text = '';
    passwordSignInController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
  }
}
