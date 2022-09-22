import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/home/controllers/home_controller.dart';
import '../routes/app_pages.dart';
import '../utils/general_utils.dart';
import '../utils/global_widgets.dart';
import '../utils/theme_data.dart';

class SideBar extends StatelessWidget {
  SideBar({
    super.key,
    required this.selectedMenu,
  });

  final scrollController = ScrollController();
  final Menus selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        height: Get.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 48, left: 20),
                child: Text(
                  'Serial Testing',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.indigo,
                  ),
                ),
              ),
              HEIGHT_12,
              Expanded(
                child: Material(
                  type: MaterialType.transparency,
                  child: ListView(
                    controller: scrollController,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      SidebarMenuItem(
                        menu: Menus.home,
                        selectedMenu: selectedMenu,
                        icon: Icons.home,
                        title: 'Home',
                        route: Routes.HOME,
                      ),
                      SidebarMenuItem(
                        menu: Menus.settings,
                        selectedMenu: selectedMenu,
                        icon: Icons.settings,
                        title: 'Settings',
                        route: Routes.SETTINGS,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SidebarMenuItem extends StatelessWidget {
  const SidebarMenuItem({
    super.key,
    required this.selectedMenu,
    required this.icon,
    required this.title,
    required this.route,
    required this.menu,
  });

  final Menus selectedMenu;
  final Menus menu;
  final IconData icon;
  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14, top: 2, bottom: 2),
      child: ListTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        leading: Icon(icon),
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
        ),
        selected: selectedMenu == menu,
        selectedTileColor: Colors.indigo.shade100,
        selectedColor: primaryColor,
        onTap: () async {
          if (Get.currentRoute == Routes.HOME) {
            if (Get.find<HomeController>().port != null) {
              Get.find<HomeController>().disconnectPort();
            }
          }
          Get.offNamed(route);
        },
      ),
    );
  }
}
