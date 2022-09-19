import 'package:flutter_libserialport/flutter_libserialport.dart';

const baudRates = [
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
];

const dataBits = [
  7,
  8,
];

const stopBits = [
  1,
  2,
];

const parity = [
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
  }
];

const flowControl = [
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
