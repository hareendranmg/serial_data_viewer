import 'package:flutter/material.dart';

import '../../controllers/home_controller.dart';

class DeviceCard extends StatelessWidget {
  const DeviceCard({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      surfaceTintColor: Colors.grey.shade300,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Expanded(child: Text('Device')),
            if (controller.serialServices.port?.isOpen ?? false)
              Chip(
                backgroundColor: Colors.green,
                label: Text(
                  '${controller.serialServices.port?.productName ?? 'Not available'} (${controller.serialServices.port?.name})',
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
      ),
    );
  }
}
