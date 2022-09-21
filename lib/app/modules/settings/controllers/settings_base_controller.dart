import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsBaseController extends GetxController {
  late final SharedPreferences box;
  final connectionFormKey = GlobalKey<FormBuilderState>();
  final generatorFormKey = GlobalKey<FormBuilderState>();
  late final ScrollController scrollController;
  late final Future<bool> isDataLoaded;

  List<SerialPort> _activePorts = [];
  bool _isConnectionSaving = false;
  bool _isGeneratorSaving = false;

  //******************** GETTERS AND SETTERS *********************/
  List<SerialPort> get activePorts => _activePorts;
  set activePorts(List<SerialPort> v) => {_activePorts = v, update()};
  bool get isConnectionSaving => _isConnectionSaving;
  set isConnectionSaving(bool v) => {_isConnectionSaving = v, update()};
  bool get isGeneratorSaving => _isGeneratorSaving;
  set isGeneratorSaving(bool v) => {_isGeneratorSaving = v, update()};
}
