import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../utils/general_utils.dart';
import '../../../../utils/global_widgets.dart';
import '../../../../utils/theme_data.dart';
import '../../controllers/home_controller.dart';

class RecieveDataCard extends StatelessWidget {
  const RecieveDataCard({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      title: const Text('Recieved data from serial port'),
      expandedTextColor: primaryColor,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: FormBuilder(
            key: controller.recievedDataFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HEIGHT_12,
                HEIGHT_12,
                Row(
                  children: [
                    Text(
                      'Response (Size: ${controller.receivedResponse.byteSize})',
                    ),
                    if (controller.receivedResponse.isNotEmpty) ...[
                      const Spacer(),
                      OutlinedButton.icon(
                        onPressed: controller.clearRecievedResponse,
                        icon: const Icon(Icons.refresh_outlined),
                        label: const Text('Clear'),
                      ),
                      WIDTH_12,
                      OutlinedButton.icon(
                        onPressed: controller.saveRecievedResponseToFile,
                        icon: const Icon(Icons.save),
                        label: const Text('Save to file'),
                      ),
                    ],
                  ],
                ),
                HEIGHT_12,
                FormBuilderTextField(
                  name: 'recieved_response',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 10,
                  readOnly: true,
                ),
                HEIGHT_12,
                if (controller.receivedError.isNotEmpty) ...[
                  const Text('Error'),
                  Text(
                    controller.receivedError,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ],
            ),
          ),
        )
      ],
    );
  }
}
