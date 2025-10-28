// lib/utils.dart
import 'package:intl/intl.dart';

String formatCurrency(double value) {
  final f = NumberFormat('#,##0', 'fa_IR');
  return f.format(value);
}

String shortDate(DateTime d) {
  final f = DateFormat('yyyy-MM-dd – kk:mm');
  return f.format(d);
}
