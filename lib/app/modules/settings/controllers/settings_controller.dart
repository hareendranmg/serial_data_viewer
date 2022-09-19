import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:get/get.dart';

import '../../../services/serial_services.dart';
import 'settings_base_controller.dart';

class SettingsController extends SettingsBaseController {
  @override
  void onInit() {
    scrollController = ScrollController();
    refreshPorts();
    super.onInit();
  }

  Future<void> refreshPorts() async {
    activePorts = await Get.find<SerialServices>().getPorts();
  }

  Future<void> saveSettings() async {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final data = formKey.currentState?.value;
      box.write('baudrate', data?['baudrate']);
      box.write('databits', data?['databits']);
      box.write('stopbits', data?['stopbits']);
      box.write('parity', data?['parity']);
      box.write('flowcontrol', data?['flowcontrol']);

      final portConfig = SerialPortConfig();
      portConfig.baudRate = data?['baudrate'] as int;
      portConfig.bits = data?['databits'] as int;
      portConfig.stopBits = data?['stopbits'] as int;
      portConfig.parity = data?['parity'] as int;
      portConfig.setFlowControl(data?['flowcontrol'] as int);
      Get.find<SerialServices>().initSerialServices(
        portName: data?['port'] as String,
        portConfig: portConfig,
      );
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
