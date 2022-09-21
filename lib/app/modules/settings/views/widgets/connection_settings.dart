import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../services/serial_services.dart';
import '../../../../utils/global_widgets.dart';
import '../../../../utils/serial_utils.dart';
import '../../controllers/settings_controller.dart';

class ConnectionSettings extends StatelessWidget {
  const ConnectionSettings({
    super.key,
    required this.controller,
  });

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 48, left: 6),
          child: Text(
            'Connection Settings',
            style: TextStyle(fontSize: 16),
          ),
        ),
        HEIGHT_12,
        Card(
          elevation: 4,
          surfaceTintColor: Colors.grey.shade300,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: FormBuilder(
              key: Get.find<SettingsController>().connectionFormKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Expanded(child: Text('Port')),
                            IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: () => controller.refreshPorts(),
                            ),
                            WIDTH_12,
                            const CustomVerticalDivider(),
                            WIDTH_12,
                            WIDTH_12,
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: FormBuilderDropdown(
                            name: 'port',
                            items: controller.activePorts
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e.name,
                                    child: Text(
                                      '${e.productName ?? 'Not available'}  (${e.name})',
                                    ),
                                  ),
                                )
                                .toList(),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Select port',
                            ),
                            validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required()],
                            ),
                            initialValue: Get.find<SerialServices>().port?.name,
                          ),
                        ),
                      ),
                    ],
                  ),
                  HEIGHT_06,
                  const Divider(thickness: 0.6),
                  HEIGHT_06,
                  Row(
                    children: [
                      const Expanded(child: Text('Baud Rate')),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: FormBuilderDropdown<int>(
                            name: 'baudrate',
                            items: SerialUtils.baudRates
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.toString()),
                                  ),
                                )
                                .toList(),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Baudrate',
                            ),
                            validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required()],
                            ),
                            initialValue:
                                controller.box.getInt('baudrate') ?? 9600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  HEIGHT_06,
                  const Divider(thickness: 0.6),
                  HEIGHT_06,
                  Row(
                    children: [
                      const Expanded(child: Text('Data Bits')),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: FormBuilderDropdown<int>(
                            name: 'databits',
                            items: SerialUtils.dataBits
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.toString()),
                                  ),
                                )
                                .toList(),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Data bits',
                            ),
                            validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required()],
                            ),
                            initialValue:
                                controller.box.getInt('databits') ?? 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                  HEIGHT_06,
                  const Divider(thickness: 0.6),
                  HEIGHT_06,
                  Row(
                    children: [
                      const Expanded(child: Text('Stop Bits')),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: FormBuilderDropdown<int>(
                            name: 'stopbits',
                            items: SerialUtils.stopBits
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.toString()),
                                  ),
                                )
                                .toList(),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Stop bits',
                            ),
                            validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required()],
                            ),
                            initialValue:
                                controller.box.getInt('stopbits') ?? 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  HEIGHT_06,
                  const Divider(thickness: 0.6),
                  HEIGHT_06,
                  Row(
                    children: [
                      const Expanded(child: Text('Parity')),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: FormBuilderDropdown<int>(
                            name: 'parity',
                            items: SerialUtils.parity
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e['value']! as int,
                                    child: Text(e['name']! as String),
                                  ),
                                )
                                .toList(),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Parity',
                            ),
                            validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required()],
                            ),
                            initialValue: controller.box.getInt('parity') ?? 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  HEIGHT_12,
                  HEIGHT_12,
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: Get.width * 0.1,
                      child: ElevatedButton(
                        onPressed: controller.isConnectionSaving
                            ? null
                            : controller.saveSettings,
                        child: controller.isConnectionSaving
                            ? const LoadingCircularIndicator()
                            : const Text('Open Port'),
                      ),
                    ),
                  ),
                ],
              ),
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
