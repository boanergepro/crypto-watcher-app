import 'package:cripto_wacher/src/core/errors/failures.dart';
import 'package:cripto_wacher/src/domain/entities/candlestick.dart';
import 'package:cripto_wacher/src/domain/entities/currency.dart';
import 'package:cripto_wacher/src/domain/repositories/binance_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CurrencyUseCase {
  final DomainBinanceRepository repository;

  const CurrencyUseCase(this.repository);

  Future<Either<Failure, List<Currency>>> getAll() async {
    return await repository.getCurrencies();
  }

  Future<Either<Failure, List<Candlestick>>> getAllCurrenciesPrices({required String symbol, required String interval}) async {
    return await repository.fetchCurrencyPrices(symbol: symbol, interval: interval);
  }

  WebSocketChannel getEstablishSocketConnectionTicker() {
    return repository.establishSocketConnectionTicker();
  }
}