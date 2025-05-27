import 'package:intl/intl.dart';

final numberFormat = NumberFormat.currency(
  locale: 'pt_AO',
  symbol: 'Kz',
  decimalDigits: 2,
  customPattern: '#,##0.00',
);
