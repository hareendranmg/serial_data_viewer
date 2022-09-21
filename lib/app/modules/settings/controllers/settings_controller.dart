import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/serial_services.dart';
import 'settings_base_controller.dart';

class SettingsController extends SettingsBaseController {
  @override
  void onInit() {
    isDataLoaded = loadData();

    super.onInit();
  }

  Future<bool> loadData() async {
    try {
      box = await SharedPreferences.getInstance();
      scrollController = ScrollController();
      refreshPorts();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> refreshPorts() async {
    activePorts = await Get.find<SerialServices>().getPorts();
  }

  Future<void> saveSettings() async {
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
        final port = await Get.find<SerialServices>().initSerialServices(
          portName: data?['port'] as String,
          portConfig: portConfig,
        );

        if (port == null) {
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
        } else {
          Get.dialog(
            AlertDialog(
              title: const Text('Success'),
              content: const Text('Settings saved and port opened'),
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

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
