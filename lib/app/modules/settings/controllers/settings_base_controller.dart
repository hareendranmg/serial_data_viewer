import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsBaseController extends GetxController {
  final box = GetStorage();
  final formKey = GlobalKey<FormBuilderState>();
  late final ScrollController scrollController;

  List<SerialPort> _activePorts = [];

  //******************** GETTERS AND SETTERS *********************/
  List<SerialPort> get activePorts => _activePorts;
  set activePorts(List<SerialPort> v) => {_activePorts = v, update()};
}
