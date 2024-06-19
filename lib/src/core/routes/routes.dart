import 'package:cripto_wacher/src/presentation/screens/home_screen.dart';
import 'package:cripto_wacher/src/presentation/screens/sign_up_screen.dart';
import 'package:cripto_wacher/src/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, _) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/sign-in',
      builder: (context, _) => const Text('Sign in'),
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, _) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, _) => const HomeScreen(),
    ),
  ],
);