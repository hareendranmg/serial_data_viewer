import 'dart:async';

import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/general_utils.dart';
import 'app/utils/theme_data.dart';
import 'package:rust_in_flutter/rust_in_flutter.dart';

Future<void> main() async {
  await RustInFlutter.ensureInitialized();
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
