import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  late final sidebarScrollController = ScrollController();

  @override
  void onClose() {
    sidebarScrollController.dispose();
    super.onClose();
  }
}
