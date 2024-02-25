import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  static final dateNow = DateTime.now();
  static final timeNow = TimeOfDay.now();
  static final dateFormatter = DateFormat('dd MMM yyyy');
  static final timeFormatter = DateFormat('hh:mm a');
  static final currentDateFormatter = DateFormat('EEEE, dd MMMM yyyy');
  static final dateTimeFormatter = DateFormat('dd MMM yyyy hh:mm a');

  static String formatDate(DateTime value) {
    return dateFormatter.format(value);
  }

  static String formatTime(DateTime value) {
    return timeFormatter.format(value);
  }

  static String formatDateTime(DateTime dateTime) {
    return dateTimeFormatter.format(dateTime);
  }

  static String formatCurrentDate() {
    return currentDateFormatter.format(dateNow);
  }

  static DateTime convertToDateTime(
      String formattedDate, String formattedTime) {
    DateTime date = dateFormatter.parse(formattedDate);
    DateTime time = timeFormatter.parse(formattedTime);

    // Combine date and time
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
