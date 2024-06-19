import 'package:intl/intl.dart';

String formatPrice(double precio) {
  final formatter = NumberFormat("#,##0.00", "en_US");
  return formatter.format(precio);
}