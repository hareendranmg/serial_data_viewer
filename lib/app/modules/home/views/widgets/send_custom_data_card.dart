import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../utils/general_utils.dart';
import '../../../../utils/global_widgets.dart';
import '../../../../utils/theme_data.dart';
import '../../controllers/home_controller.dart';

class SendCustomDataCard extends StatelessWidget {
  const SendCustomDataCard({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      surfaceTintColor: Colors.grey.shade300,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: const Text('Send custom data to serial port'),
          textColor: primaryColor,
          iconColor: primaryColor,
          tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: FormBuilder(
                key: controller.customDataFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormBuilderTextField(
                      name: 'custom_data',
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 5,
                      validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()],
                      ),
                      onChanged: (value) => controller.customData = value!,
                    ),
                    HEIGHT_12,
                    Row(
                      children: [
                        Text('Size: ${controller.customData.byteSize}'),
                        const Spacer(),
                        OutlinedButton.icon(
                          onPressed: () {
                            controller.customDataFormKey.currentState?.reset();
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reset'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: controller.sendCustomData,
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
                        Text(
                          'Response (Size: ${controller.customResponse.byteSize})',
                        ),
                        OutlinedButton.icon(
                          onPressed: controller.saveCustomResponseToFile,
                          icon: const Icon(Icons.save),
                          label: const Text('Save to file'),
                        ),
                      ],
                    ),
                    HEIGHT_12,
                    FormBuilderTextField(
                      name: 'custom_response',
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 5,
                      readOnly: true,
                      onChanged: (value) => controller.customResponse = value!,
                    ),
                    HEIGHT_12,
                    if (kDebugMode) ...[
                      const Text('Error'),
                      Text(
                        controller.customError,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
