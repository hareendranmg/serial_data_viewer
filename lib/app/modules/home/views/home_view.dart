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
          SideBar(menu: Menus.home),
          const HomeBody(),
        ],
      ),
    );
  }
}
