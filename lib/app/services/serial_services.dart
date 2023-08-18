import 'package:flutter/foundation.dart';
import 'package:msgpack_dart/msgpack_dart.dart';
import 'package:rust_in_flutter/rust_in_flutter.dart';

import '../data/serial_port.dart';

class SerialServices {
  static Future<SerialPort?> connect({
    required String portName,
  }) async {
    // try {
    //   final port = SerialPort(portName);

    //   if (port.isOpen) port.close();

    //   port.openReadWrite();
    //   await 1.delay();
    //   port.config.baudRate = portConfig.baudRate;
    //   port.config.bits = portConfig.bits;
    //   port.config.stopBits = portConfig.stopBits;
    //   port.config.parity = portConfig.parity;
    //   // port?.config.setFlowControl(portConfig.f);

    //   if (kDebugMode) print('is open: ${port.isOpen}');

    //   return port.isOpen ? port : null;
    // } catch (e) {
    // if (kDebugMode) {
    //   print('error: $e');
    //   rethrow;
    // }

    return null;
  }

  static int write(SerialPort port, String data) {
    // try {
    //   if (port.isOpen) {
    //     final bytes = Uint8List.fromList(utf8.encode(data));

    //     return port.write(bytes, timeout: 0);
    //   }

    //   return 0;
    // } catch (e) {
    // if (kDebugMode) rethrow;

    return 0;
  }

  static Future<List<SerialPort>> getPorts() async {
    try {
      final rustRequest = RustRequest(
        address: 'serial.getPorts',
        operation: RustOperation.Read,
        bytes: serialize({}),
      );

      final rustResponse = await requestToRust(rustRequest);
      final message = deserialize(rustResponse.bytes) as Map;
      print(message['ports']);

      return (message['ports'] as Map)
          .map((k, v) => MapEntry(k, SerialPort(k as String, v as String)))
          .values
          .toList();
    } catch (e) {
      if (kDebugMode) rethrow;

      return [];
    }
  }
}
