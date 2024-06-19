import 'dart:convert';

import 'package:cripto_wacher/src/data/datasources/binance_remote_data_source.dart';
import 'package:cripto_wacher/src/data/models/crypto_model.dart';
import 'package:cripto_wacher/src/data/repositories/binance_repository.dart';
import 'package:cripto_wacher/src/domain/entities/candlestick.dart';
import 'package:cripto_wacher/src/domain/entities/currency.dart';
import 'package:cripto_wacher/src/domain/repositories/binance_repository.dart';
import 'package:cripto_wacher/src/domain/usecases/currencies.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

const List<String> intervals = [
  '1m', '5m', '2h', '1d', '1M'
];

class BinanceController with ChangeNotifier {
  final IBinanceRemoteDataSource _remoteDataSource = BinanceRemoteDataSource();
  late final DomainBinanceRepository _domainBinanceRepository;
  late final CurrencyUseCase _usecase;

  BinanceController() {
    _domainBinanceRepository = DataBinanceRepository(_remoteDataSource);
    _usecase = CurrencyUseCase(_domainBinanceRepository);
  }
  Currency? currencyValue;
  List<Currency> listCurrencies = [];
  List<Candlestick> listCurrenciesPrices = [];
  List<CryptoModel> listCrypto = [];
  CryptoModel? cryptoSelected;
  WebSocketChannel? _channel;
  String intervalSelected = intervals.first;

  void setInterval(String interval) {
    intervalSelected = interval;
    getCurrenciesPrices(symbol: cryptoSelected!.symbol, interval: intervalSelected);
    notifyListeners();
  }

  void goToDetail({required CryptoModel crypto, required BuildContext context}) {
    // set currency fo select
    currencyValue = listCurrencies.firstWhere((element) => element.symbol == crypto.symbol);
    // set value for select
    cryptoSelected = crypto;
    // fetch data for charts
    getCurrenciesPrices(symbol: crypto.symbol, interval: '1d');
    // navigation
    context.go('/detail-chart');
  }

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
    _channel = _usecase.getEstablishSocketConnectionTicker();

    _channel?.stream.listen((message) {
      var parse = json.decode(message);
      //channel.sink.close(status.goingAway);
      if (parse is List) {
        listCrypto = List<CryptoModel>.from(parse.map((e) => CryptoModel.fromJson(e))).toList().where((element) => element.symbol.endsWith('USDT')).toList();
        notifyListeners();
      }
    });
  }
}