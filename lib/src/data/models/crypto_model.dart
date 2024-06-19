import 'package:cripto_wacher/src/core/utils/format_price.dart';
import 'package:cripto_wacher/src/core/utils/get_name_currency.dart';

class CryptoModel {
  final String cryptoName;
  final String symbol;
  final double volume;
  final String lastPrice;
  final double priceChangePercent;

  CryptoModel({
    required this.cryptoName,
    required this.symbol,
    required this.volume,
    required this.lastPrice,
    required this.priceChangePercent,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      cryptoName: getNameCurrency(json['s']),
      symbol: json['s'],
      volume: double.parse(json['v']),
      lastPrice: formatPrice(double.parse(json['c'])),
      priceChangePercent: double.parse(json['P']),
    );
  }
}
