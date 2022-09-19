import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../utils/global_widgets.dart';
import '../../../../utils/serial_utils.dart';
import '../../controllers/settings_controller.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FormBuilder(
          key: Get.find<SettingsController>().formKey,
          child: GetBuilder<SettingsController>(
            builder: (_) {
              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 48),
                    child: Text('Settings', style: TextStyle(fontSize: 20)),
                  ),
                  HEIGHT_12,
                  HEIGHT_12,
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: FormBuilderDropdown(
                                name: 'port',
                                items: _.activePorts
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.name,
                                        child: Text(
                                          '${e.productName ?? 'Not available'}  (${e.name})',
                                        ),
                                      ),
                                    )
                                    .toList(),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Port',
                                ),
                                validator: FormBuilderValidators.compose(
                                  [FormBuilderValidators.required()],
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: () => _.refreshPorts(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FormBuilderDropdown<int>(
                          name: 'baudrate',
                          items: baudRates
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.toString()),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Baudrate',
                          ),
                          validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()],
                          ),
                          initialValue: _.box.read('baudrate') ?? 9600,
                        ),
                      ),
                    ],
                  ),
                  HEIGHT_12,
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderDropdown<int>(
                          name: 'databits',
                          items: dataBits
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.toString()),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Data bits',
                          ),
                          validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()],
                          ),
                          initialValue: _.box.read('databits') ?? 8,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FormBuilderDropdown<int>(
                          name: 'stopbits',
                          items: stopBits
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.toString()),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Stop bits',
                          ),
                          validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()],
                          ),
                          initialValue: _.box.read('stopbits') ?? 1,
                        ),
                      ),
                    ],
                  ),
                  HEIGHT_12,
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderDropdown<int>(
                          name: 'parity',
                          items: parity
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e['value']! as int,
                                  child: Text(e['name']! as String),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Parity',
                          ),
                          validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()],
                          ),
                          initialValue: _.box.read('parity') ?? 0,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FormBuilderDropdown<int>(
                          name: 'flowcontrol',
                          items: flowControl
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e['value']! as int,
                                  child: Text(e['name']! as String),
                                ),
                              )
                              .toList(),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Flow control',
                          ),
                          validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()],
                          ),
                          initialValue: _.box.read('flowcontrol') ?? 0,
                        ),
                      ),
                    ],
                  ),
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
                          onPressed: _.saveSettings,
                          child: const Text('Save'),
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
