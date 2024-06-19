class CandlestickModel {
  final DateTime time;
  final double open;
  final double high;
  final double low;
  final double close;

  CandlestickModel({
    required this.time,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  factory CandlestickModel.fromJson(List<dynamic> json) {
    return CandlestickModel(
      time: DateTime.fromMillisecondsSinceEpoch(json[0]),
      open: double.parse(json[1]),
      high: double.parse(json[2]),
      low: double.parse(json[3]),
      close: double.parse(json[4]),
    );
  }
}
