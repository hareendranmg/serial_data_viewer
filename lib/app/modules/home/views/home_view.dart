import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_widgets/sidebar.dart';
import '../../../utils/general_utils.dart';
import '../controllers/home_controller.dart';
import 'widgets/home_body.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(selectedMenu: Menus.home),
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
                  return snapshot.hasError
                      ? const Center(
                          child: Text('Error occured. Please restart the app'),
                        )
                      : const HomeBody();

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
