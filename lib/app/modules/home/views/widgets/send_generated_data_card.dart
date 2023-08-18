import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../utils/general_utils.dart';
import '../../../../utils/global_widgets.dart';
import '../../../../utils/theme_data.dart';
import '../../controllers/home_controller.dart';

class SendGeneratedDataCard extends StatelessWidget {
  const SendGeneratedDataCard({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      title: const Text('Send genereated data to serial port'),
      expandedTextColor: primaryColor,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: FormBuilder(
            key: controller.generatedDataFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Send ${controller.pattern} string ${controller.timesToSend} times',
                    ),
                    Text(' (${controller.generatedData.byteSize})'),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: controller.isGeneratedDataSending
                          ? null
                          : controller.sendGeneratedData,
                      icon: const Icon(Icons.send),
                      label: const Text('Send'),
                    ),
                  ],
                ),
                HEIGHT_12,
                HEIGHT_12,
                Row(
                  children: [
                    Text(
                      'Response (Size: ${controller.generatedResponse.byteSize})',
                    ),
                    if (controller.generatedResponse.isNotEmpty) ...[
                      const Spacer(),
                      OutlinedButton.icon(
                        onPressed: controller.clearGeneratedResponse,
                        icon: const Icon(Icons.refresh_outlined),
                        label: const Text('Clear'),
                      ),
                      WIDTH_12,
                      OutlinedButton.icon(
                        onPressed: controller.saveGeneratedResponseToFile,
                        icon: const Icon(Icons.save),
                        label: const Text('Save to file'),
                      ),
                    ],
                  ],
                ),
                HEIGHT_12,
                FormBuilderTextField(
                  name: 'generated_response',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 10,
                  readOnly: true,
                ),
                HEIGHT_12,
                if (controller.generatedError.isNotEmpty) ...[
                  const Text('Error'),
                  Text(
                    controller.generatedError,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
