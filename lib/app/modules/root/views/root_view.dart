import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/theme_data.dart';
import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  const RootView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: FutureBuilder(
          future: controller.initServices(),
          builder: (context, snapshot) {
            return Center(
              child: Column(
                children: const [
                  Spacer(),
                  Text(
                    'Serail Testing',
                    style: TextStyle(color: primaryColor, fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(primaryColor),
                  ),
                  SizedBox(height: 42),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
