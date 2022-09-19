import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class RootController extends GetxController {
  Future initServices() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Get.offNamed(Routes.HOME),
    );
  }
}
