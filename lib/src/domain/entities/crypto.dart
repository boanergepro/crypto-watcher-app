import 'package:equatable/equatable.dart';

class Cryptdo extends Equatable {
  final String cryptoName;
  final String symbol;
  final double volume;
  final double lastPrice;
  final double priceChangePercent;

  const Cryptdo({
    required this.cryptoName,
    required this.symbol,
    required this.volume,
    required this.lastPrice,
    required this.priceChangePercent,
  });

  @override
  List<Object?> get props => [
        cryptoName,
        symbol,
        volume,
        lastPrice,
        priceChangePercent,
      ];
}
