class CryptoModel {
  final String symbol;
  final double volume;
  final double lastPrice;
  final double priceChangePercent;

  CryptoModel({
    required this.symbol,
    required this.volume,
    required this.lastPrice,
    required this.priceChangePercent,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      symbol: json['s'],
      volume: double.parse(json['v']),
      lastPrice: double.parse(json['c']),
      priceChangePercent: double.parse(json['P']),
    );
  }
}
