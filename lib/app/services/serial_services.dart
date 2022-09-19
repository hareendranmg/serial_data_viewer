import 'dart:convert';
import 'dart:developer';

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
      port?.dispose();
      port?.close();
      port = null;
      port = SerialPort(portName);
      port?.config = portConfig;

      // port?.openReadWrite();
      if (!(port?.isOpen ?? true)) {
        port?.openReadWrite();
      }

      log('Serial Service Status: ${port?.isOpen}');
      return port;
    } catch (e) {
      log('Serial Service Status: ${port?.isOpen}');
      if (kDebugMode) rethrow;
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
