import 'package:employee_list/app/modules/home/widgets/empty_widget.dart';
import 'package:employee_list/app/routes/app_pages.dart';
import 'package:employee_list/app/theme/custom_theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: const EmptyWidget(),
      floatingActionButton: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.radius8),
            color: Get.theme.primaryColor),
        child: IconButton(
          onPressed: () => Get.toNamed(Routes.ADD_EMPLOYEE),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
