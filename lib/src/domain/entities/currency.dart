import 'package:equatable/equatable.dart';

class Currency extends Equatable{
  final String symbol;
  final String price;

  const Currency({
    required this.symbol,
    required this.price,
  });

  @override
  List<Object?> get props => [
    symbol, price
  ];
}
