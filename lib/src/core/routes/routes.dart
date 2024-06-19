import 'package:cripto_wacher/src/presentation/screens/detail_chart_screen.dart';
import 'package:cripto_wacher/src/presentation/screens/home_screen.dart';
import 'package:cripto_wacher/src/presentation/screens/sign_in_screen.dart';
import 'package:cripto_wacher/src/presentation/screens/sign_up_screen.dart';
import 'package:cripto_wacher/src/presentation/screens/welcome_screen.dart';
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
      builder: (context, _) => const SignInScreen(),
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, _) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, _) => const HomeScreen(),
    ),
    GoRoute(
      path: '/detail-chart',
      builder: (context, _) => const DetailChartScreen(),
    ),
  ],
);
