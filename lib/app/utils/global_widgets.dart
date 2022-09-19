import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'theme_data.dart';

enum SnackbarType {
  success,
  warning,
  error,
}

final lightBlueGradient = [Colors.indigo.shade200, Colors.indigo.shade50];
final blueGradient = [const Color(0xFF1B90F7), Colors.blue.shade300];
final tealGradient = [const Color(0xFF00897B), Colors.teal.shade300];
final deepPurpleGradient = [const Color(0xFF7361F7), Colors.indigo.shade200];
final redGradient = [const Color(0xFFF8456C), Colors.red.shade200];
final brownGradient = [Colors.brown, Colors.brown.shade200];
final cyanGradient = [Colors.cyan, Colors.cyan.shade200];
final orangeGradient = [Colors.orange[600]!, Colors.orange.shade200];

const HEIGHT_12 = SizedBox(height: 12);

void showSnackBar({
  required SnackbarType type,
  required String message,
  Duration? duration,
}) {
  final Color fontColor =
      type == SnackbarType.warning ? Colors.black : Colors.white;

  final Color bgColor = type == SnackbarType.success
      ? const Color(0xff28a745)
      : type == SnackbarType.warning
          ? const Color(0xffffc107)
          : const Color(0xffdc3545);
  Get.showSnackbar(
    GetSnackBar(
      message: message,
      messageText: Text(message, style: TextStyle(color: fontColor)),
      backgroundColor: bgColor,
      icon: type == SnackbarType.success
          ? Icon(Icons.check, color: fontColor)
          : Icon(Icons.error_outline, color: fontColor),
      duration: duration ?? 3.seconds,
      shouldIconPulse: false,
    ),
  );
}

Future<void> showCustomBottomSheet(BuildContext context, Widget child) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
    ),
    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: child,
      ),
    ),
  );
}

class LoadingCircularIndicator extends StatelessWidget {
  const LoadingCircularIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 18,
      width: 18,
      child: CircularProgressIndicator(
        color: primaryColor,
        strokeWidth: 3,
      ),
    );
  }
}

void showLsapDialog(String title, String content) {
  Get.dialog(
    AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        ElevatedButton(
          onPressed: () => Get.back(),
          child: const Text('Ok'),
        )
      ],
    ),
  );
}
