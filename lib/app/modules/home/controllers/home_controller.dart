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

      receivedScrollController.addListener(() {
        if (receivedScrollController.position.pixels ==
            receivedScrollController.position.maxScrollExtent) {
          receivedScrollController.animateTo(
            receivedScrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });

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

        port = await openPort(data?['port'] as String, portConfig);

        if (port == null) {
          Get.dialog(
            AlertDialog(
              title: const Text('Error'),
              content: const Text(
                'Unable to connect to the port. Please try again.',
              ),
              actions: [
                OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          deviceCardKey.currentState?.collapse();

          subscription?.onData((event) {
            final currentTime = DateTime.now();
            final customCurrentTimeFormat =
                '${currentTime.hour}:${currentTime.minute}:${currentTime.second}';
            receivedResponse +=
                '$customCurrentTimeFormat, ${String.fromCharCodes(event)}';
            recievedDataFormKey.currentState?.fields['recieved_response']
                ?.didChange(receivedResponse);
          });
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
            OutlinedButton(
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

  Future<SerialPort?> openPort(String portName, SerialPortConfig config) async {
    try {
      port = await SerialServices.connect(
        portName: portName,
        portConfig: config,
      );

      reader = SerialPortReader(port!);
      subscription =
          reader?.stream.listen((event) {}, onDone: () {}, onError: (e) {});

      return port;
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
        print(e);
      }

      return null;
    }
  }

  Future<void> clearRecievedResponse() async {
    receivedResponse = '';
    receivedError = '';
    recievedDataFormKey.currentState?.fields['recieved_response']
        ?.didChange('');
  }

  Future<void> saveRecievedResponseToFile() async {
    final file = await saveResponseToFile(receivedResponse);

    if (file != null) {
      Get.dialog(
        AlertDialog(
          title: const Text('Success'),
          content: Text('File saved successfully at ${file.path}'),
          actions: [
            OutlinedButton(
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

  Future<void> sendCustomData() async {
    try {
      if (customDataFormKey.currentState?.saveAndValidate() ?? false) {
        customData =
            customDataFormKey.currentState?.value['custom_data'] as String;
        if (port != null && (port?.isOpen ?? false)) {
          isCustomDataSending = true;
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
                OutlinedButton(
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
    } finally {
      isCustomDataSending = false;
    }
  }

  Future<void> sendGeneratedData() async {
    try {
      if (port != null && (port?.isOpen ?? false)) {
        final buffer = StringBuffer();
        final watch = Stopwatch();

        isGeneratedDataSending = true;
        await 1.delay();
        generatedData = '';
        generatedError = '';
        generatedResponse = '';
        port?.flush();

        watch.reset();
        watch.start();

        for (int i = 0; i < timesToSend; i++) {
          buffer.write(pattern);
        }

        generatedData = buffer.toString();
        buffer.clear();

        watch.stop();

        print('time to generate data: ${watch.elapsed.inMilliseconds} ms');

        watch.reset();
        watch.start();
        SerialServices.write(port!, generatedData);
        watch.stop();
        print('Time to send data: ${watch.elapsed.inMilliseconds} ms');

        watch.reset();
        watch.start();

        subscription?.onData((event) {
          generatedResponse += String.fromCharCodes(event);
          generatedDataFormKey.currentState?.fields['generated_response']
              ?.didChange(generatedResponse);
        });

        watch.stop();
        print('Time to receive data: ${watch.elapsed.inSeconds} seconds');

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
              OutlinedButton(
                onPressed: () => Get.back(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) rethrow;
      generatedError = e.toString();
    } finally {
      isGeneratedDataSending = false;
    }
  }

  void clearGeneratedResponse() {
    generatedData = '';
    generatedResponse = '';
    generatedError = '';
    generatedDataFormKey.currentState?.fields['generated_response']
        ?.didChange(generatedResponse);
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
            OutlinedButton(
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

  Future<void> saveGeneratedResponseToFile() async {
    final file = await saveResponseToFile(generatedResponse);

    if (file != null) {
      Get.dialog(
        AlertDialog(
          title: const Text('Success'),
          content: Text('File saved successfully at ${file.path}'),
          actions: [
            OutlinedButton(
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
      final fileName = 'sda_$customCurrentTimeFormat.csv';

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
              OutlinedButton(
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
            OutlinedButton(
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
