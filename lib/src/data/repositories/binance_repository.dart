import 'package:cripto_wacher/src/core/errors/failures.dart';
import 'package:cripto_wacher/src/data/datasources/binance_remote_data_source.dart';
import 'package:cripto_wacher/src/domain/entities/candlestick.dart';
import 'package:cripto_wacher/src/domain/entities/currency.dart';
import 'package:cripto_wacher/src/domain/repositories/binance_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:web_socket_channel/src/channel.dart';

class DataBinanceRepository implements DomainBinanceRepository {
  final IBinanceRemoteDataSource _remoteDataSource;

  const DataBinanceRepository(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Currency>>> getCurrencies() async {
    try {
      final response = await _remoteDataSource.getCurrencies();
      if (response != null) {
        return Right(response);
      }

      return const Left(ServerFailure('Error fetch currencies'));
    } catch (err) {
      return Left(ServerFailure(err as String));
    }
  }

  @override
  Future<Either<Failure, List<Candlestick>>> fetchCurrencyPrices(
      {required String symbol, required String interval}) async {
    try {
      final response = await _remoteDataSource.fetchCurrencyPrices(
          symbol: symbol, interval: interval);

      if (response != null) {
        List<Candlestick> result = List<Candlestick>.from(
          response.map(
            (e) => Candlestick(
              time: e.time,
              open: e.open,
              high: e.high,
              low: e.low,
              close: e.close,
            ),
          ),
        );

        return Right(result);
      }
      return const Left(ServerFailure('Error fetching currencies prices'));
    } catch (err) {
      return Left(ServerFailure(err as String));
    }
  }

  @override
  WebSocketChannel establishSocketConnectionTicker() {
    return _remoteDataSource.establishSocketConnectionTicker();
  }
}
