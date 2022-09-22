import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/serial_services.dart';
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

      refreshPorts();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> refreshPorts() async {
    activePorts = await SerialServices.getPorts();
  }

  Future<void> connectPort() async {
    try {
      if (connectionFormKey.currentState?.saveAndValidate() ?? false) {
        isConnectionSaving = true;
        final data = connectionFormKey.currentState?.value;
        await box.setInt('baudrate', data?['baudrate'] as int);
        await box.setInt('databits', data?['databits'] as int);
        await box.setInt('stopbits', data?['stopbits'] as int);
        await box.setInt('parity', data?['parity'] as int);
        // box.write('flowcontrol', data?['flowcontrol']);

        final portConfig = SerialPortConfig();
        portConfig.baudRate = data?['baudrate'] as int;
        portConfig.bits = data?['databits'] as int;
        portConfig.stopBits = data?['stopbits'] as int;
        portConfig.parity = data?['parity'] as int;
        // portConfig.setFlowControl(data?['flowcontrol'] as int);
        port = await SerialServices.connect(
          portName: data?['port'] as String,
          portConfig: portConfig,
        );

        reader = SerialPortReader(port!);
        subscription =
            reader?.stream.listen((event) {}, onDone: () {}, onError: (e) {});

        if (port == null) {
          Get.dialog(
            AlertDialog(
              title: const Text('Error'),
              content: const Text(
                'Unable to connect to the port. Please try again.',
              ),
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
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: const Text(
            'Could not open port. Please check your settings and reconnect the device',
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      if (kDebugMode) rethrow;
    } finally {
      isConnectionSaving = false;
    }
  }

  Future<void> sendCustomData() async {
    try {
      if (customDataFormKey.currentState?.saveAndValidate() ?? false) {
        customData =
            customDataFormKey.currentState?.value['custom_data'] as String;
        if (port != null && (port?.isOpen ?? false)) {
          customError = '';
          customResponse = '';
          customDataFormKey.currentState?.fields['custom_response']?.reset();
          port?.flush();

          SerialServices.write(port!, customData);

          subscription?.onData((event) {
            customResponse += String.fromCharCodes(event);
            customDataFormKey.currentState?.fields['custom_response']
                ?.didChange(customResponse);
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
      customError = e.toString();
    }
  }

  Future<void> sendGeneratedData() async {
    try {
      if (port != null && (port?.isOpen ?? false)) {
        isGeneratedDataSending = true;
        port?.flush();
        String response = '';
        // int generatedDataBytes = 0;
        // final int generatedResponseBytes = 0;

        // final elapsed = Stopwatch()..start();

        for (int i = 0; i < timesToSend; i++) {
          SerialServices.write(port!, pattern);
          // generatedDataBytes += pattern.length;
        }
        final reader = SerialPortReader(port!);

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

  void disconnectPortDialog() {
    try {
      Get.dialog(
        AlertDialog(
          title: const Text('Disconnect'),
          content: const Text('Are you sure you want to disconnect?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                disconnectPort();
                Get.back();
              },
              child: const Text('Disconnect'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (kDebugMode) rethrow;
    }
  }

  void disconnectPort() {
    try {
      if (port?.isOpen ?? false) port?.close();

      port?.flush();
      port?.dispose();
      reader?.close();
      port = null;
      reader = null;
      subscription?.cancel();
      subscription = null;
    } catch (e) {
      if (kDebugMode) rethrow;
    }
  }

  @override
  void onClose() {
    disconnectPort();

    super.onClose();
  }
}
