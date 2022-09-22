import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../utils/global_widgets.dart';
import '../../../../utils/theme_data.dart';
import '../../controllers/home_controller.dart';

class SendGenratedDataCard extends StatelessWidget {
  const SendGenratedDataCard({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      surfaceTintColor: Colors.grey.shade300,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: const Text('Send genereated data to serial port'),
          textColor: primaryColor,
          iconColor: primaryColor,
          tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          children: [
            Card(
              elevation: 4,
              surfaceTintColor: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: FormBuilder(
                  key: controller.generatedDataFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              'Send ${controller.pattern} string ${controller.timesToSend} times',
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: controller.isGeneratedDataSending
                                ? null
                                : controller.sendGeneratedData,
                            icon: const Icon(Icons.send),
                            label: controller.isGeneratedDataSending
                                ? const LoadingCircularIndicator()
                                : const Text('Send'),
                          ),
                        ],
                      ),
                      HEIGHT_12,
                      HEIGHT_12,
                      Row(
                        children: [
                          const Expanded(child: Text('Response')),
                          OutlinedButton.icon(
                            label: const Text('Details'),
                            icon: const Icon(Icons.info_outline),
                            onPressed: () =>
                                controller.showGeneratedResponseDetails,
                          ),
                          WIDTH_12,
                          OutlinedButton.icon(
                            onPressed: controller.saveCustomResponseToFile,
                            icon: const Icon(Icons.save),
                            label: const Text('Save to file'),
                          ),
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
            )
          ],
        ),
      ),
    );
  }
}
