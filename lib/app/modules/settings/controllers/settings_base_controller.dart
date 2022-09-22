import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsBaseController extends GetxController {
  late final SharedPreferences box;
  final generatorFormKey = GlobalKey<FormBuilderState>();
  late final ScrollController scrollController;
  late final Future<bool> isDataLoaded;

  bool _isGeneratorSaving = false;

  //******************** GETTERS AND SETTERS *********************/
  bool get isGeneratorSaving => _isGeneratorSaving;
  set isGeneratorSaving(bool v) => {_isGeneratorSaving = v, update()};
}
