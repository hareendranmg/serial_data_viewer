import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'home_base_controller.dart';

class HomeController extends HomeBaseController {
  @override
  void onInit() {
    isDataLoaded = loadData();
    super.onInit();
  }

  Future<bool> loadData() async {
    try {
      box = await SharedPreferences.getInstance();
      scrollController = ScrollController();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> sendData() async {
    try {
      if (customDataFormKey.currentState?.saveAndValidate() ?? false) {
        final data = customDataFormKey.currentState?.value['data'] as String;
        if (serialServices.port?.isOpen ?? false) {
          serialServices.port?.flush();
          serialServices.write(data);

          await 1.delay(() {
            final bytes = serialServices.port!
                .read(serialServices.port!.bytesAvailable, timeout: 0);
            response = String.fromCharCodes(bytes);
            customDataFormKey.currentState?.fields['response']
                ?.didChange(response);
          });
        } else {
          Get.dialog(
            AlertDialog(
              title: const Text('Error'),
              content: const Text('Serial Port is not open'),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      error = e.toString();
    }
  }

  Future<void> saveResponseToFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      final currentTime = DateTime.now();
      final customCurrentTimeFormat =
          '${currentTime.year}${currentTime.month}${currentTime.day}${currentTime.hour}${currentTime.minute}${currentTime.second}';
      final fileName = 'sda_$customCurrentTimeFormat.txt';

      final filePath = '${directory.path}${Platform.pathSeparator}$fileName';

      final fileBytes = response.codeUnits;

      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);

      Get.dialog(
        AlertDialog(
          title: const Text('Success'),
          content: Text('File saved successfully at $filePath'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
            ElevatedButton(
              onPressed: () => openFile(filePath),
              child: const Text('Open File'),
            ),
          ],
        ),
      );
    } catch (e) {
      error = e.toString();
    }
  }

  Future<void> openFile(String filePath) async {
    try {
      Get.back();
      final uri = Uri.file(filePath);

      if (!await launchUrl(uri)) {
        Get.dialog(
          AlertDialog(
            title: const Text('Error'),
            content: const Text('Failed to open file'),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) rethrow;
    }
  }
}
