import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/serial_services.dart';

class HomeBaseController extends GetxController {
  late final SharedPreferences box;
  final customDataFormKey = GlobalKey<FormBuilderState>();
  final generatedDataFormKey = GlobalKey<FormBuilderState>();
  final responseDetailsFormKey = GlobalKey<FormBuilderState>();
  late final ScrollController scrollController;
  final serialServices = Get.find<SerialServices>();
  late final Future<bool> isDataLoaded;

  late final String pattern;
  late final int timesToSend;

  bool _isCustomDataSending = false;
  bool _isGeneratedDataSending = false;

  String customResponse = '';
  String generatedResponse = '';

  String _customError = '';
  String _generatedError = '';

  //******************** GETTERS AND SETTERS *********************/
  bool get isCustomDataSending => _isCustomDataSending;
  set isCustomDataSending(bool v) => {_isCustomDataSending = v, update()};

  bool get isGeneratedDataSending => _isGeneratedDataSending;
  set isGeneratedDataSending(bool v) => {_isGeneratedDataSending = v, update()};

  String get customError => _customError;
  set customError(String v) => {_customError = v, update()};

  String get generatedError => _generatedError;
  set generatedError(String v) => {_generatedError = v, update()};
}
