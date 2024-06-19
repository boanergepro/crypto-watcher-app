import 'package:cripto_wacher/src/presentation/controllers/auth/sign_up_controller.dart';
import 'package:cripto_wacher/src/presentation/widgets/buttons/custom_contained_button.dart';
import 'package:cripto_wacher/src/presentation/widgets/fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(16),
          child: Consumer<SignUpController>(
            builder: (context, state, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // title screen
                  const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // fields

                  // email
                  CustomField(
                    controller: state.emailController,
                    errorMessage: state.errorEmailText,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Email',
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  // password
                  CustomField(
                    controller: state.passwordController,
                    errorMessage: state.errorPasswordText,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: 'Password',
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  // confirm password
                  CustomField(
                    controller: state.confirmPasswordController,
                    errorMessage: state.errorPasswordText,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: 'Confirm password',
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomContainedButton(
                    fullWidth: true,
                    onPressed: () => state.handleSignUp(context),
                    text: 'Get started',
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
