import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/global_widgets.dart';
import '../../controllers/home_controller.dart';
import 'device_card.dart';
import 'send_custom_data_card.dart';
import 'send_generated_data_card.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Padding(
        padding: const EdgeInsets.only(top: 28, left: 6),
        child: GetBuilder<HomeController>(
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  DeviceCard(controller: _),
                  SendCustomDataCard(controller: _),
                  SendGenratedDataCard(controller: _),
                  HEIGHT_12,
                  HEIGHT_12,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
