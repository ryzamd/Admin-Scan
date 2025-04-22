import 'package:intl/intl.dart';

class DateFormatter {
  static String formatTimestamp(String? timestamp) {
    if (timestamp == null || timestamp.isEmpty) {
      return 'No data';
    }
    
    try {
      final DateTime dateTime = DateTime.parse(timestamp);
      final DateFormat formatter = DateFormat('yy-MM-dd - HH:mm:ss');
      return formatter.format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }
  
  static String formatCustom(String? timestamp, String format) {
    if (timestamp == null || timestamp.isEmpty) {
      return 'No data';
    }
    
    try {
      final DateTime dateTime = DateTime.parse(timestamp);
      final DateFormat formatter = DateFormat(format);
      return formatter.format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }
}