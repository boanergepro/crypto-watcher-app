import 'dart:convert';

import 'package:cripto_wacher/src/data/datasources/binance_remote_data_source.dart';
import 'package:cripto_wacher/src/data/models/crypto_model.dart';
import 'package:cripto_wacher/src/data/repositories/binance_repository.dart';
import 'package:cripto_wacher/src/domain/entities/candlestick.dart';
import 'package:cripto_wacher/src/domain/entities/currency.dart';
import 'package:cripto_wacher/src/domain/repositories/binance_repository.dart';
import 'package:cripto_wacher/src/domain/usecases/currencies.dart';
import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {
  final IBinanceRemoteDataSource _remoteDataSource = BinanceRemoteDataSource();
  late final DomainBinanceRepository _domainBinanceRepository;
  late final CurrencyUseCase _usecase;

  HomeController() {
    _domainBinanceRepository = DataBinanceRepository(_remoteDataSource);
    _usecase = CurrencyUseCase(_domainBinanceRepository);
  }
  Currency? currencyValue;
  List<Currency> listCurrencies = [];
  List<Candlestick> listCurrenciesPrices = [];
  List<CryptoModel> listCrypto = [];

  void getCurrencies() async {
    var result = await _usecase.getAll();

    result.fold((failure) {
      print('error ${failure.message}');
    }, (currencies) {
      listCurrencies = currencies.where((element) => element.symbol.endsWith('USDT')).toList();
      notifyListeners();
    });
  }

  void getCurrenciesPrices({required String symbol, required String interval}) async {
    var result = await _usecase.getAllCurrenciesPrices(symbol: symbol, interval: interval);

    result.fold((failure) {
      print('error ${failure.message}');
    }, (currenciesPrices) {
      listCurrenciesPrices = currenciesPrices;
      notifyListeners();
    });
  }

  void establishSocketConnectionTicker() {
    var channel = _usecase.getEstablishSocketConnectionTicker();

    channel.stream.listen((message) {
      var parse = json.decode(message);
      //channel.sink.close(status.goingAway);
      if (parse is List) {
        listCrypto = List<CryptoModel>.from(parse.map((e) => CryptoModel.fromJson(e))).toList();
        print(listCrypto.first.symbol);
      }

    });
  }
}