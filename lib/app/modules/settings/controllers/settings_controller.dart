import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/global_widgets.dart';
import 'settings_base_controller.dart';

class SettingsController extends SettingsBaseController {
  @override
  void onInit() {
    isDataLoaded = loadData();

    super.onInit();
  }

  Future<bool> loadData() async {
    try {
      box = await SharedPreferences.getInstance();
      scrollController = ScrollController();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> saveGeneratorSettings() async {
    try {
      if (generatorFormKey.currentState?.saveAndValidate() ?? false) {
        isGeneratorSaving = true;
        final data = generatorFormKey.currentState?.value;
        await box.setString('pattern', data?['pattern'] as String);
        await box.setInt('times_to_send', data?['times_to_send'] as int);

        Get.reload();

        showSnackBar(type: SnackbarType.success, message: 'Settings saved');
      }
    } catch (e) {
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: const Text(
            'Could not save settings. Please try again',
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      if (kDebugMode) rethrow;
    } finally {
      isGeneratorSaving = false;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
