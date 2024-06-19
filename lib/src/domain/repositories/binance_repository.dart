import 'package:cripto_wacher/src/core/errors/failures.dart';
import 'package:cripto_wacher/src/domain/entities/candlestick.dart';
import 'package:cripto_wacher/src/domain/entities/currency.dart';
import 'package:dartz/dartz.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class DomainBinanceRepository {
  Future<Either<Failure, List<Currency>>> getCurrencies();
  Future<Either<Failure, List<Candlestick>>> fetchCurrencyPrices({required String symbol, required String interval});
  WebSocketChannel establishSocketConnectionTicker();
}
