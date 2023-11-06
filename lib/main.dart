import 'package:employee_list/app/theme/custom_theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      title: "Employee List",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: CustomTheme.customTheme,
    ),
  );
}
