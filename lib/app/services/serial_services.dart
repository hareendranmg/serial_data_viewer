import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:get/get.dart';

class SerialServices extends GetxService {
  String? portName;
  SerialPort? port;
  // late final SerialPortReader reader;
  // late final Stream readerStream;

  Future<SerialServices> init() async {
    return this;
  }

  Future<SerialPort?> initSerialServices({
    required String portName,
    required SerialPortConfig portConfig,
  }) async {
    try {
      port?.close();
      port?.dispose();
      port = null;
      port = SerialPort(portName);

      if (port?.isOpen ?? false) {
        port?.close();
      }

      port?.openReadWrite();
      await 2.delay();
      port?.config.baudRate = portConfig.baudRate;
      port?.config.bits = portConfig.bits;
      port?.config.stopBits = portConfig.stopBits;
      port?.config.parity = portConfig.parity;
      // port?.config.setFlowControl(portConfig.f);

      if (kDebugMode) {
        print('is open: ${port?.isOpen}');
      }
      return port?.isOpen ?? false ? port : null;
    } catch (e) {
      if (kDebugMode) {
        print('error: $e');
        rethrow;
      }
      return null;
    }
  }

  int write(String data) {
    try {
      if (port?.isOpen ?? false) {
        final bytes = Uint8List.fromList(utf8.encode(data));
        return port!.write(bytes, timeout: 0);
      }
      return -1;
    } catch (e) {
      if (kDebugMode) rethrow;
      return -1;
    }
  }

  void disposePort() {
    try {
      port?.dispose();
    } catch (e) {
      if (kDebugMode) rethrow;
    }
  }

  Future<List<SerialPort>> getPorts() async {
    try {
      final ports = SerialPort.availablePorts;
      return ports.map((e) => SerialPort(e)).toList();
    } catch (e) {
      if (kDebugMode) rethrow;
      return [];
    }
  }
}
