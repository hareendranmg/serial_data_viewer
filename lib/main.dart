import 'dart:async';

import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/general_utils.dart';
import 'app/utils/theme_data.dart';

Future<void> main() async {
  await initializeApp();

  runApp(
    GetMaterialApp(
      title: 'Serial Test',
      initialRoute: AppPages.INITIAL,
      defaultTransition: Transition.noTransition,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: themeData,
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
      ],
    ),
  );
}
