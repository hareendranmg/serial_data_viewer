import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../../../utils/global_widgets.dart';
import '../../controllers/settings_controller.dart';
import 'connection_settings.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: FormBuilder(
          key: Get.find<SettingsController>().formKey,
          child: GetBuilder<SettingsController>(
            builder: (_) {
              return ListView(
                children: [
                  ConnectionSettings(controller: _),
                  HEIGHT_12,
                  HEIGHT_12,
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _.formKey.currentState?.reset();
                            _.refreshPorts();
                          },
                          child: const Text('Reset'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _.inAsyncCall ? null : _.saveSettings,
                          child: _.inAsyncCall
                              ? const LoadingCircularIndicator()
                              : const Text('Save'),
                        ),
                      ),
                    ],
                  ),
                  HEIGHT_12,
                  HEIGHT_12,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
