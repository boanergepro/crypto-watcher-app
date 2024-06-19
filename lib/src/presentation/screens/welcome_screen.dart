import 'package:cripto_wacher/src/presentation/widgets/buttons/custom_contained_button.dart';
import 'package:cripto_wacher/src/presentation/widgets/buttons/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                // Name app
                Text(
                  'CriptoWacher',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                // description
                Text(
                  'An application to observe cryptocurrencies in real time.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                // sign in button
                CustomContainedButton(
                  onPressed: () {},
                  text: 'Sign in',
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('New user?'),
                    CustomTextButton(
                      text: 'Get Started',
                      onPressed: () => context.push('/sign-up'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
