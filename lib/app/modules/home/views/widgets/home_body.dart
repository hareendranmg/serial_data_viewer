import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../utils/global_widgets.dart';
import '../../controllers/home_controller.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FormBuilder(
          key: Get.find<HomeController>().formKey,
          child: GetBuilder<HomeController>(
            builder: (_) {
              return ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                controller: _.scrollController,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 48),
                    child: Center(
                      child: Text('Home', style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  HEIGHT_12,
                  const Text('Send data to serial port'),
                  HEIGHT_12,
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
                  const Text('Device'),
                  HEIGHT_12,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: _.serialServices.port?.isOpen ?? false
                        ? Chip(
                            backgroundColor: Colors.green,
                            label: Text(
                              '${_.serialServices.port?.productName ?? 'Not available'} (${_.serialServices.port?.name})',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const Chip(
                            backgroundColor: Colors.red,
                            label: Text(
                              'Disconnected',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                  ),
                  HEIGHT_12,
                  HEIGHT_12,
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _.formKey.currentState?.reset();
                          },
                          child: const Text('Reset'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _.sendData,
                          child: const Text('Send'),
                        ),
                      ),
                    ],
                  ),
                  HEIGHT_12,
                  HEIGHT_12,
                  HEIGHT_12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Response'),
                      OutlinedButton(
                        onPressed: _.saveResponseToFile,
                        child: const Text('Save to file'),
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
                  if (_.error.isNotEmpty) ...[
                    const Text('Error'),
                    Text(_.error, style: const TextStyle(color: Colors.red)),
                  ],
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
