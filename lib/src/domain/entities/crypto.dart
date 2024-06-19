import 'package:equatable/equatable.dart';

class Crypto extends Equatable {
  final String symbol;
  final double volume;
  final double lastPrice;
  final double priceChangePercent;

  const Crypto({
    required this.symbol,
    required this.volume,
    required this.lastPrice,
    required this.priceChangePercent,
  });

  @override
  List<Object?> get props => [
        symbol,
        volume,
        lastPrice,
        priceChangePercent,
      ];
}
