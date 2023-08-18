// data class for SerialPort

class SerialPort {
  late final String portName;
  late final String portDescription;

  SerialPort(this.portName, this.portDescription);

  SerialPort.fromJson(Map<String, String> json) {
    portName = json['portName']!;
    portDescription = json['portDescription']!;
  }
}
