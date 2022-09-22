import 'package:flutter/material.dart' hide Key;
import 'package:get/get.dart';
import 'package:window_size/window_size.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  setWindowTitle('Serial Testing');
  setWindowMinSize(Size(Get.width * 0.5, Get.height * 0.8));
  // setWindowMaxSize(Size());
}

extension StringExtensions on String {
  String get titleCase => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.capitalizeFirst)
      .join(' ');

  String get byteSize => getByteSize(this);
}

extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 7).floor() >= 1) {
      return numericDates ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return numericDates ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return numericDates ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return numericDates ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}

void removeCurrentFocus(BuildContext context) {
  final currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

String removeTrailingZeros(String value) {
  return value.replaceAll(RegExp(r'\:00+$'), '');
}

String getGreeting() {
  final hour = TimeOfDay.now().hour;
  if (hour > 0 && hour <= 12) {
    return 'Good Morning';
  } else if (hour > 12 && hour <= 18) {
    return 'Good Afternoon';
  } else if (hour > 18 && hour <= 24) {
    return 'Good Evening';
  } else {
    return 'Hello';
  }
}

enum Menus { home, settings }

String getByteSize(String value) {
  final bytes = value.length;
  if (bytes < 1024) {
    return '$bytes bytes';
  } else if (bytes < 1024 * 1024) {
    return '${(bytes / 1024).toStringAsFixed(2)} KB';
  } else if (bytes < 1024 * 1024 * 1024) {
    return '${(bytes / 1024 / 1024).toStringAsFixed(2)} MB';
  } else {
    return '${(bytes / 1024 / 1024 / 1024).toStringAsFixed(2)} GB';
  }
}
