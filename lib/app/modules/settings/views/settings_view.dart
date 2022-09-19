import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/sidebar.dart';
import '../../../utils/general_utils.dart';
import '../controllers/settings_controller.dart';
import 'widgets/settings_body.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(menu: Menus.settings),
          const SettingsBody(),
        ],
      ),
    );
  }
}
