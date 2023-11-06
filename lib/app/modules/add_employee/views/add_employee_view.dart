import 'package:employee_list/app/theme/custom_theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_employee_controller.dart';

class AddEmployeeView extends GetView<AddEmployeeController> {
  const AddEmployeeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
      ),
      body: Column(
        children: [
         
          const Spacer(),
          Container(
            decoration: const BoxDecoration(
                border: Border(
              top: BorderSide(width: 1.0, color: Colors.black12),
            )),
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 73,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Get.theme.colorScheme.secondary,
                        borderRadius:
                            BorderRadius.circular(AppConstants.radius6)),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(color: Get.theme.colorScheme.primary),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 73,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Get.theme.colorScheme.primary,
                        borderRadius:
                            BorderRadius.circular(AppConstants.radius6)),
                    child: Center(
                      child: Text(
                        'Save',
                        style: Get.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
