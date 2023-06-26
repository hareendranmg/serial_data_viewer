import 'package:flutter_libserialport/flutter_libserialport.dart';

class SerialUtils {
  static const baudRates = [
    300,
    600,
    1200,
    1800,
    2400,
    4800,
    9600,
    14400,
    19200,
    28800,
    38400,
    57600,
    115200,
    230400,
    460800,
    921600,
    1000000,
    2000000,
    2500000,
    3000000,
    3500000,
    4000000,
  ];

  static const dataBits = [
    7,
    8,
  ];

  static const stopBits = [
    1,
    2,
  ];

  static const parity = [
    {
      'name': 'None',
      'value': SerialPortParity.none,
    },
    {
      'name': 'Even',
      'value': SerialPortParity.even,
    },
    {
      'name': 'Odd',
      'value': SerialPortParity.odd,
    },
    {
      'name': 'Mark',
      'value': SerialPortParity.mark,
    },
    {
      'name': 'Space',
      'value': SerialPortParity.space,
    },
  ];

  static const flowControl = [
    {
      'name': 'None',
      'value': SerialPortFlowControl.none,
    },
    {
      'name': 'Hardware (DTR/DSR)',
      'value': SerialPortFlowControl.dtrDsr,
    },
    {
      'name': 'Hardware (RTS/CTS)',
      'value': SerialPortFlowControl.rtsCts,
    },
    {
      'name': 'Software (XON/XOFF)',
      'value': SerialPortFlowControl.xonXoff,
    },
  ];
}
