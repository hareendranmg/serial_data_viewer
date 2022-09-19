import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';
import '../utils/general_utils.dart';
import '../utils/global_widgets.dart';
import '../utils/theme_data.dart';

class SideBar extends StatelessWidget {
  SideBar({
    super.key,
    required this.menu,
  });

  final scrollController = ScrollController();
  final Menus menu;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
        ),
        child: Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 48),
                child: Text(
                  'Serial Testing',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),
              HEIGHT_12,
              Expanded(
                child: ListView(
                  controller: scrollController,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text(
                        'Home',
                        overflow: TextOverflow.ellipsis,
                      ),
                      selected: menu == Menus.home,
                      selectedColor: primaryColor,
                      onTap: () => Get.offNamed(Routes.HOME),
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text(
                        'Settings',
                        overflow: TextOverflow.ellipsis,
                      ),
                      selected: menu == Menus.settings,
                      selectedColor: primaryColor,
                      onTap: () => Get.offNamed(Routes.SETTINGS),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
