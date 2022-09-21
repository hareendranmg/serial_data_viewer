import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../views/widgets/response_details.dart';
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

      pattern = box.getString('pattern') ?? '0123456789';
      timesToSend = box.getInt('times_to_send') ?? 100;

      scrollController = ScrollController();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> sendCustomData() async {
    // Timer.periodic(const Duration(milliseconds: 40), (timer) {
    //   final bytes = serialServices.port!
    //       .read(serialServices.port!.bytesAvailable, timeout: 0);
    //   customResponse += String.fromCharCodes(bytes);
    //   if (serialServices.port!.bytesAvailable == 0) {
    //     timer.cancel();
    //     customDataFormKey.currentState?.fields['custom_response']
    //         ?.didChange(customResponse);
    //   }
    // });
    try {
      if (customDataFormKey.currentState?.saveAndValidate() ?? false) {
        final customData =
            customDataFormKey.currentState?.value['custom_data'] as String;
        if (serialServices.port?.isOpen ?? false) {
          generatedDataFormKey.currentState?.fields['generated_response']
              ?.reset();
          serialServices.port?.flush();
          customResponse = '';
          final List<int> resposeBytes = [];

          serialServices.write(customData);
          print(serialServices.port?.bytesAvailable ?? 'null');
          final reader = SerialPortReader(serialServices.port!);
          await 1.seconds.delay();

          print('333333333333');
          print(reader.port.bytesAvailable);
          print('333333333333');

          reader.stream.listen((data) {
            print('object');
            resposeBytes.addAll(data);
          }).onError((error) {
            print(error);
          });

          reader.close();
          customResponse += String.fromCharCodes(resposeBytes);
          // generatedResponseBytes += data.length;
          generatedDataFormKey.currentState?.fields['generated_response']
              ?.didChange(customResponse);
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
      generatedError = e.toString();
    }
  }

  Future<void> sendGeneratedData() async {
    try {
      if (serialServices.port?.isOpen ?? false) {
        isGeneratedDataSending = true;
        serialServices.port?.flush();
        String response = '';
        // int generatedDataBytes = 0;
        // final int generatedResponseBytes = 0;

        // final elapsed = Stopwatch()..start();

        for (int i = 0; i < timesToSend; i++) {
          serialServices.write(pattern);
          // generatedDataBytes += pattern.length;
        }
        final reader = SerialPortReader(serialServices.port!);

        // await 1.delay();

        reader.stream.listen((data) {
          response += String.fromCharCodes(data);
          // generatedResponseBytes += data.length;
          generatedDataFormKey.currentState?.fields['generated_response']
              ?.didChange(response);
        });
        reader.close();

        // elapsed.stop();

        // final elapsedSeconds = elapsed.elapsedMilliseconds / 1000;
        // final dataRate = generatedDataBytes / elapsedSeconds;
        // final responseRate = generatedResponseBytes / elapsedSeconds;

        // responseDetailsFormKey.currentState?.fields['data_bytes']
        //     ?.didChange(generatedDataBytes.toString());
        // responseDetailsFormKey.currentState?.fields['response_bytes']
        //     ?.didChange(generatedResponseBytes.toString());
        // responseDetailsFormKey.currentState?.fields['elapsed_time']
        //     ?.didChange(elapsedSeconds.toStringAsFixed(2));
        // responseDetailsFormKey.currentState?.fields['data_rate']
        //     ?.didChange(dataRate.toStringAsFixed(2));
        // responseDetailsFormKey.currentState?.fields['response_rate']
        //     ?.didChange(responseRate.toStringAsFixed(2));
        // responseDetailsFormKey.currentState?.fields['speed']?.didChange(
        //   (responseRate / generatedDataBytes * 100).toStringAsFixed(2),
        // );
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
    } catch (e) {
      generatedError = e.toString();
    } finally {
      isGeneratedDataSending = false;
    }
  }

  void showGeneratedResponseDetails() {
    Get.dialog(
      const AlertDialog(
        content: ResponseDetails(),
      ),
    );
  }

  Future<void> saveCustomResponseToFile() async {
    final file = await saveResponseToFile(customResponse);

    if (file != null) {
      Get.dialog(
        AlertDialog(
          title: const Text('Success'),
          content: Text('File saved successfully at ${file.path}'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
            ElevatedButton(
              onPressed: () => openFile(file.path),
              child: const Text('Open File'),
            ),
          ],
        ),
      );
    }
  }

  Future<File?> saveResponseToFile(String data) async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      final currentTime = DateTime.now();
      final customCurrentTimeFormat =
          '${currentTime.year}${currentTime.month}${currentTime.day}${currentTime.hour}${currentTime.minute}${currentTime.second}';
      final fileName = 'sda_$customCurrentTimeFormat.txt';

      final filePath = '${directory.path}${Platform.pathSeparator}$fileName';

      final fileBytes = data.codeUnits;

      return File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);
    } catch (e) {
      generatedError = e.toString();

      return null;
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
