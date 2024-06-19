import 'dart:async';
import 'dart:convert';

import 'package:cripto_wacher/src/core/utils/validate_email.dart';
import 'package:cripto_wacher/src/data/repositories/binance_repository.dart';
import 'package:cripto_wacher/src/domain/repositories/binance_repository.dart';
import 'package:cripto_wacher/src/domain/usecases/currencies.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../data/datasources/binance_remote_data_source.dart';


class SignUpController with ChangeNotifier {
  final IBinanceRemoteDataSource _remoteDataSource = BinanceRemoteDataSource();
  late final DomainBinanceRepository _domainBinanceRepository;
  late final CurrencyUseCase _usecase;

  SignUpController() {
    _domainBinanceRepository = DataBinanceRepository(_remoteDataSource);
    _usecase = CurrencyUseCase(_domainBinanceRepository);
  }

  // controller for text fields

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  // error message fields
  String? errorEmailText;
  String? errorPasswordText;

  // validation methods
  void emailValidation(String value) {
    if (!validateEmail(value)) {
      errorEmailText = 'Email is not valid';
      notifyListeners();
    }
  }

  void passwordValidation(String value) {
    if (passwordController.text != confirmPasswordController.text) {
      errorPasswordText = 'The passwords dont match';
      notifyListeners();
    }
  }

  // handle sign up method
  void handleSignUp(BuildContext context) async {
    print('Sign Up');
    context.go('/home');
    // final wsUrl = Uri.parse('wss://stream.binance.com:9443/ws');
    // final channel = WebSocketChannel.connect(wsUrl);
    //
    // await channel.ready;
    //
    // var data = {
    //   "method": "SUBSCRIBE",
    //   "params": [
    //     "!ticker@arr",
    //   ],
    // };
    //
    // channel.sink.add(json.encode(data));
    // channel.stream.listen((message) {
    //
    //   //channel.sink.close(status.goingAway);
    //   print(message);
    // });
  }


}
