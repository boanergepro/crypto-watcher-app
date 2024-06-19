import 'package:cripto_wacher/src/core/routes/routes.dart';
import 'package:cripto_wacher/src/presentation/controllers/auth/auth_controller.dart';
import 'package:cripto_wacher/src/presentation/controllers/binance/binance_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => BinanceController()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
