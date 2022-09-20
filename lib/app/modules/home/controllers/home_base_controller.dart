import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/serial_services.dart';

class HomeBaseController extends GetxController {
  late final SharedPreferences box;
  final formKey = GlobalKey<FormBuilderState>();
  late final ScrollController scrollController;
  final serialServices = Get.find<SerialServices>();

  String _error = '';
  String _response = '';

  //******************** GETTERS AND SETTERS *********************/
  String get error => _error;
  set error(String v) => {_error = v, update()};

  String get response => _response;
  set response(String v) => {_response = v, update()};
}
