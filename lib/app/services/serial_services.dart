import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:get/get.dart';

class SerialServices {
  static Future<SerialPort?> connect({
    required String portName,
    required SerialPortConfig portConfig,
  }) async {
    try {
      final port = SerialPort(portName);

      if (port.isOpen) port.close();

      port.openReadWrite();
      await 1.delay();
      port.config.baudRate = portConfig.baudRate;
      port.config.bits = portConfig.bits;
      port.config.stopBits = portConfig.stopBits;
      port.config.parity = portConfig.parity;
      // port?.config.setFlowControl(portConfig.f);

      if (kDebugMode) print('is open: ${port.isOpen}');

      return port.isOpen ? port : null;
    } catch (e) {
      if (kDebugMode) {
        print('error: $e');
        rethrow;
      }
      return null;
    }
  }

  static int write(SerialPort port, String data) {
    try {
      if (port.isOpen) {
        final bytes = Uint8List.fromList(utf8.encode(data));
        return port.write(bytes, timeout: 0);
      }
      return 0;
    } catch (e) {
      if (kDebugMode) rethrow;
      return 0;
    }
  }

  static Future<List<SerialPort>> getPorts() async {
    try {
      final ports = SerialPort.availablePorts;
      return ports.map((e) => SerialPort(e)).toList();
    } catch (e) {
      if (kDebugMode) rethrow;
      return [];
    }
  }
}
