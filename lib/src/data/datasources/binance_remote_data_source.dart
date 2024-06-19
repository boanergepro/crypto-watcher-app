import 'dart:convert';

import 'package:cripto_wacher/src/data/models/candlestick_model.dart';
import 'package:cripto_wacher/src/data/models/currency_model.dart';
import 'package:dio/dio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class IBinanceRemoteDataSource {
  Future<List<CurrencyModel>?> getCurrencies();
  Future<List<CandlestickModel>?> fetchCurrencyPrices({required String symbol, required String interval});
  WebSocketChannel establishSocketConnectionTicker();
}

class BinanceRemoteDataSource implements IBinanceRemoteDataSource {
  final dio = Dio();
  static const String _baseUrl = 'https://api.binance.com';

  @override
  Future<List<CurrencyModel>?> getCurrencies() async {
    try {
      const uri = "$_baseUrl/api/v3/ticker/price";

      final res = await dio.get<List>(uri);

      final arr = res.data?.map((e) => CurrencyModel.fromJson(e)).toList();

      return arr;
    } catch (e) {
      print('error $e');
      return null;
    }
  }
  @override
  Future<List<CandlestickModel>?> fetchCurrencyPrices({required String symbol, required String interval}) async {
    try {
      var uri = '$_baseUrl/api/v3/klines?symbol=$symbol&interval=$interval';

      final res = await dio.get<List>(uri);

      final arr = res.data?.map((e) => CandlestickModel.fromJson(e)).toList();

      return arr;
    } catch (e) {
      return null;
    }
  }

  @override
  WebSocketChannel establishSocketConnectionTicker() {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws'),
    );

    channel.sink.add(
      jsonEncode(
        {
          "method": "SUBSCRIBE",
          "params": [
            "!ticker@arr",
          ],
        },
      ),
    );

    return channel;
  }
}

