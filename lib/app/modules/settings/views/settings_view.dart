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
          FutureBuilder<bool>(
            future: controller.isDataLoaded,
            initialData: false,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error occured. Please restart the app'),
                    );
                  } else {
                    return const SettingsBody();
                  }

                default:
                  return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
