import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../utils/global_widgets.dart';
import '../../../../utils/theme_data.dart';
import '../../controllers/home_controller.dart';

class SendCustomDataCard extends StatelessWidget {
  const SendCustomDataCard({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HEIGHT_12,
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: const Text('Send custom data to serial port'),
            textColor: primaryColor,
            iconColor: primaryColor,
            tilePadding: const EdgeInsets.all(4),
            children: [
              Card(
                elevation: 4,
                surfaceTintColor: Colors.grey.shade300,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: FormBuilder(
                    key: controller.customDataFormKey,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: 'data',
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 5,
                          validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()],
                          ),
                        ),
                        HEIGHT_12,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {
                                controller.customDataFormKey.currentState
                                    ?.reset();
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text('Reset'),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton.icon(
                              onPressed: controller.sendData,
                              icon: const Icon(Icons.send),
                              label: const Text('Send'),
                            ),
                          ],
                        ),
                        HEIGHT_12,
                        HEIGHT_12,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Response'),
                            OutlinedButton.icon(
                              onPressed: controller.saveResponseToFile,
                              icon: const Icon(Icons.save),
                              label: const Text('Save to file'),
                            ),
                          ],
                        ),
                        HEIGHT_12,
                        FormBuilderTextField(
                          name: 'response',
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 10,
                          readOnly: true,
                        ),
                        HEIGHT_12,
                        if (controller.error.isNotEmpty) ...[
                          const Text('Error'),
                          Text(
                            controller.error,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
