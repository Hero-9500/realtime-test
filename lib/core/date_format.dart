import 'package:intl/intl.dart';

extension StringX on DateTime {
  String get mmmmyyy => DateFormat('MMMM yyy').format(this).toString();
  String get ddmmmyyyy => DateFormat('d MMM yyyy').format(this).toString();
}
