import 'package:intl/intl.dart';

String dateFormat(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}
