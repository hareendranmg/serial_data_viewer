import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../utils/global_widgets.dart';
import '../../../../utils/serial_utils.dart';
import '../../../../utils/theme_data.dart';
import '../../controllers/home_controller.dart';

class DeviceCard extends StatelessWidget {
  const DeviceCard({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      key: controller.deviceCardKey,
      expandedTextColor: primaryColor,
      initiallyExpanded: true,
      title: Row(
        children: [
          const Expanded(child: Text('Device')),
          if (controller.port != null)
            Chip(
              backgroundColor: Colors.green,
              label: Text(
                '${controller.port?.portDescription ?? 'Not available'} (${controller.port?.portName})',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          else
            const Chip(
              backgroundColor: Colors.red,
              label: Text(
                'Disconnected',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: FormBuilder(
            key: controller.connectionFormKey,
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
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: FormBuilderDropdown(
                          name: 'port',
                          items: controller.activePorts
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e.portName,
                                  child: Text(
                                    '${e.portDescription ?? 'Not available'}  (${e.portName})',
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
                          // initialValue: controller.port?.isOpen ?? false
                          //     ? controller.port?.name
                          //     : null,
                        ),
                      ),
                    ),
                  ],
                ),
                HEIGHT_12,
                Row(
                  children: [
                    const Expanded(child: Text('Baud Rate')),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
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
                HEIGHT_12,
                Row(
                  children: [
                    const Expanded(child: Text('Data Bits')),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
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
                          initialValue: controller.box.getInt('databits') ?? 8,
                        ),
                      ),
                    ),
                  ],
                ),
                HEIGHT_12,
                Row(
                  children: [
                    const Expanded(child: Text('Stop Bits')),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
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
                          initialValue: controller.box.getInt('stopbits') ?? 1,
                        ),
                      ),
                    ),
                  ],
                ),
                HEIGHT_12,
                Row(
                  children: [
                    const Expanded(child: Text('Parity')),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
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
                      onPressed: () {},
                      child: const Text('Connect'),
                      // onPressed: controller.isConnectionSaving
                      //     ? null
                      //     : (controller.port?.isOpen ?? false)
                      //         ? controller.disconnectPortDialog
                      //         : controller.connectPort,
                      // child: controller.isConnectionSaving
                      //     ? const LoadingCircularIndicator()
                      //     : (controller.port?.isOpen ?? false)
                      //         ? const Text('Disconnect')
                      //         : const Text('Connect'),
                    ),
                  ),
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
      color: Colors.grey.shade200,
    );
  }
}


// ExpansionPanel buildDeviceCard(HomeController controller) {
//   return ExpansionPanel(
//     canTapOnHeader: true,
//     isExpanded: controller.selectedCard == HomeCard.device,
//     headerBuilder: (context, isExpanded) => Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 12,
//         vertical: 6,
//       ),
//       child: Row(
//         children: [
//           const Expanded(child: Text('Device')),
//           if (controller.port?.isOpen ?? false)
//             Chip(
//               backgroundColor: Colors.green,
//               label: Text(
//                 '${controller.port?.productName ?? 'Not available'} (${controller.port?.name})',
//                 style: const TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             )
//           else
//             const Chip(
//               backgroundColor: Colors.red,
//               label: Text(
//                 'Disconnected',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//         ],
//       ),
//     ),
//     body: Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 24,
//         vertical: 12,
//       ),
//       child: FormBuilder(
//         key: controller.connectionFormKey,
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Row(
//                     children: [
//                       const Expanded(child: Text('Port')),
//                       IconButton(
//                         icon: const Icon(Icons.refresh),
//                         onPressed: () => controller.refreshPorts(),
//                       ),
//                       WIDTH_12,
//                       const CustomVerticalDivider(),
//                       WIDTH_12,
//                       WIDTH_12,
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: FormBuilderDropdown(
//                       name: 'port',
//                       items: controller.activePorts
//                           .map(
//                             (e) => DropdownMenuItem(
//                               value: e.name,
//                               child: Text(
//                                 '${e.productName ?? 'Not available'}  (${e.name})',
//                               ),
//                             ),
//                           )
//                           .toList(),
//                       decoration: const InputDecoration.collapsed(
//                         hintText: 'Select port',
//                       ),
//                       validator: FormBuilderValidators.compose(
//                         [FormBuilderValidators.required()],
//                       ),
//                       initialValue: controller.port?.isOpen ?? false
//                           ? controller.port?.name
//                           : null,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             HEIGHT_12,
//             Row(
//               children: [
//                 const Expanded(child: Text('Baud Rate')),
//                 Expanded(
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: FormBuilderDropdown<int>(
//                       name: 'baudrate',
//                       items: SerialUtils.baudRates
//                           .map(
//                             (e) => DropdownMenuItem(
//                               value: e,
//                               child: Text(e.toString()),
//                             ),
//                           )
//                           .toList(),
//                       decoration: const InputDecoration.collapsed(
//                         hintText: 'Baudrate',
//                       ),
//                       validator: FormBuilderValidators.compose(
//                         [FormBuilderValidators.required()],
//                       ),
//                       initialValue: controller.box.getInt('baudrate') ?? 9600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             HEIGHT_12,
//             Row(
//               children: [
//                 const Expanded(child: Text('Data Bits')),
//                 Expanded(
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: FormBuilderDropdown<int>(
//                       name: 'databits',
//                       items: SerialUtils.dataBits
//                           .map(
//                             (e) => DropdownMenuItem(
//                               value: e,
//                               child: Text(e.toString()),
//                             ),
//                           )
//                           .toList(),
//                       decoration: const InputDecoration.collapsed(
//                         hintText: 'Data bits',
//                       ),
//                       validator: FormBuilderValidators.compose(
//                         [FormBuilderValidators.required()],
//                       ),
//                       initialValue: controller.box.getInt('databits') ?? 8,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             HEIGHT_12,
//             Row(
//               children: [
//                 const Expanded(child: Text('Stop Bits')),
//                 Expanded(
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: FormBuilderDropdown<int>(
//                       name: 'stopbits',
//                       items: SerialUtils.stopBits
//                           .map(
//                             (e) => DropdownMenuItem(
//                               value: e,
//                               child: Text(e.toString()),
//                             ),
//                           )
//                           .toList(),
//                       decoration: const InputDecoration.collapsed(
//                         hintText: 'Stop bits',
//                       ),
//                       validator: FormBuilderValidators.compose(
//                         [FormBuilderValidators.required()],
//                       ),
//                       initialValue: controller.box.getInt('stopbits') ?? 1,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             HEIGHT_12,
//             Row(
//               children: [
//                 const Expanded(child: Text('Parity')),
//                 Expanded(
//                   child: Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: FormBuilderDropdown<int>(
//                       name: 'parity',
//                       items: SerialUtils.parity
//                           .map(
//                             (e) => DropdownMenuItem(
//                               value: e['value']! as int,
//                               child: Text(e['name']! as String),
//                             ),
//                           )
//                           .toList(),
//                       decoration: const InputDecoration.collapsed(
//                         hintText: 'Parity',
//                       ),
//                       validator: FormBuilderValidators.compose(
//                         [FormBuilderValidators.required()],
//                       ),
//                       initialValue: controller.box.getInt('parity') ?? 0,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             HEIGHT_12,
//             HEIGHT_12,
//             Align(
//               alignment: Alignment.centerRight,
//               child: SizedBox(
//                 width: Get.width * 0.1,
//                 child: ElevatedButton(
//                   onPressed: controller.isConnectionSaving
//                       ? null
//                       : (controller.port?.isOpen ?? false)
//                           ? controller.disconnectPortDialog
//                           : controller.connectPort,
//                   child: controller.isConnectionSaving
//                       ? const LoadingCircularIndicator()
//                       : (controller.port?.isOpen ?? false)
//                           ? const Text('Disconnect')
//                           : const Text('Connect'),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
