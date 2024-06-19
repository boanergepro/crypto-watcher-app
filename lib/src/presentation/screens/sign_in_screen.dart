import 'package:cripto_wacher/src/presentation/controllers/auth/auth_controller.dart';
import 'package:cripto_wacher/src/presentation/widgets/buttons/custom_contained_button.dart';
import 'package:cripto_wacher/src/presentation/widgets/fields/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.pop();
            //Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Consumer<AuthController>(
            builder: (context, state, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // title screen
                   Text(
                    'Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Theme.of(context).primaryColor
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  // fields

                  // email
                  CustomField(
                    controller: state.emailSignInController,
                    errorMessage: state.errorEmailText,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Email',
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  // password
                  CustomField(
                    controller: state.passwordSignInController,
                    errorMessage: state.errorPasswordText,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: 'Password',
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  state.errorSignIn != null ? Center(
                    child: Text(state.errorSignIn!, style: const TextStyle(
                      color: Colors.redAccent,
                    ),),
                  ) : const SizedBox(),

                  const SizedBox(
                    height: 50,
                  ),
                  CustomContainedButton(
                    fullWidth: true,
                    onPressed: () => state.handleSignIn(context),
                    text: 'Sign in',
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
