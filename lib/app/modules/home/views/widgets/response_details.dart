import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class ResponseDetails extends StatelessWidget {
  const ResponseDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: FormBuilder(
        key: Get.find<HomeController>().responseDetailsFormKey,
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text('Total data bytes sent'),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: FormBuilderTextField(
                      name: 'data_bytes',
                      decoration: const InputDecoration.collapsed(hintText: ''),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(thickness: 0.6),
            Row(
              children: [
                const Expanded(
                  child: Text('Total data bytes received'),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: FormBuilderTextField(
                      name: 'response_bytes',
                      decoration: const InputDecoration.collapsed(hintText: ''),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(thickness: 0.6),
            Row(
              children: [
                const Expanded(
                  child: Text('Elapsed time'),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: FormBuilderTextField(
                      name: 'elapsed_time',
                      decoration: const InputDecoration.collapsed(hintText: ''),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(thickness: 0.6),
            Row(
              children: [
                const Expanded(
                  child: Text('Send rate'),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: FormBuilderTextField(
                      name: 'data_rate',
                      decoration: const InputDecoration.collapsed(hintText: ''),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(thickness: 0.6),
            Row(
              children: [
                const Expanded(
                  child: Text('Receive rate'),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: FormBuilderTextField(
                      name: 'response_rate',
                      decoration: const InputDecoration.collapsed(hintText: ''),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(thickness: 0.6),
            Row(
              children: [
                const Expanded(
                  child: Text('Speed'),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: FormBuilderTextField(
                      name: 'speed',
                      decoration: const InputDecoration.collapsed(hintText: ''),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(thickness: 0.6),
          ],
        ),
      ),
    );
  }
}
