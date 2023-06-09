import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../utils/global_widgets.dart';
import '../../../../utils/theme_data.dart';
import '../../controllers/settings_controller.dart';

class GeneratorSettings extends StatelessWidget {
  const GeneratorSettings({
    super.key,
    required this.controller,
  });

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      title: const Text('Generator Settings'),
      initiallyExpanded: true,
      expandedTextColor: primaryColor,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: FormBuilder(
            key: Get.find<SettingsController>().generatorFormKey,
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(child: Text('Pattern')),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: FormBuilderTextField(
                          name: 'pattern',
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Pattern to send',
                          ),
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(1),
                              FormBuilderValidators.maxLength(30),
                            ],
                          ),
                          initialValue: controller.box.getString('pattern') ??
                              '0123456789',
                        ),
                      ),
                    ),
                  ],
                ),
                HEIGHT_12,
                Row(
                  children: [
                    const Expanded(child: Text('Times to send')),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.indigo.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: FormBuilderTextField(
                          name: 'times_to_send',
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Times to send',
                          ),
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.min(1),
                              FormBuilderValidators.max(10000000),
                            ],
                          ),
                          initialValue:
                              "${(controller.box.getInt('times_to_send')) ?? 100}",
                          keyboardType: TextInputType.number,
                          valueTransformer: (value) =>
                              int.tryParse(value ?? '0'),
                        ),
                      ),
                    ),
                  ],
                ),
                HEIGHT_12,
                HEIGHT_12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: controller.isGeneratorSaving
                          ? null
                          : controller.saveGeneratorSettings,
                      child: controller.isGeneratorSaving
                          ? const LoadingCircularIndicator()
                          : const Text('Save Settings'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 1,
      color: Colors.grey.shade300,
    );
  }
}
