import 'package:cripto_wacher/src/domain/entities/currency.dart';

class CurrencyModel extends Currency {
  const CurrencyModel({
    required String symbol,
    required String price,

  }) : super(
    symbol: symbol,
    price: price
  );

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      symbol: json['symbol'] as String,
      price: json['price'] as String,
    );
  }
}
