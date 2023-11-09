import 'package:employee_list/app/theme/custom_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_employee_controller.dart';

class AddEmployeeView extends GetView<AddEmployeeController> {
  const AddEmployeeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.isEdit
            ? 'Edit Employee Details'
            : 'Add Employee Details'),
        automaticallyImplyLeading: false,
        actions: [
          if (controller.isEdit)
            IconButton(
                onPressed: () => controller.deleteEmployee(),
                icon: const Icon(CupertinoIcons.delete))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                EmployeeNameInput(controller: controller),
                const SizedBox(
                  height: 24,
                ),
                RoleSelection(
                  controller: controller,
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    FromDateSelection(
                      controller: controller,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Get.theme.primaryColor,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    ToDateSelection(
                      controller: controller,
                    ),
                  ],
                )
              ],
            ),
          ),
          const Spacer(),
          BottomSaveCancelWidget(controller: controller)
        ],
      ),
    );
  }
}

class BottomSaveCancelWidget extends StatelessWidget {
  const BottomSaveCancelWidget({
    super.key,
    required this.controller,
  });

  final AddEmployeeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(width: 1.0, color: Colors.black12),
      )),
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 73,
              height: 40,
              decoration: BoxDecoration(
                  color: Get.theme.colorScheme.secondary,
                  borderRadius: BorderRadius.circular(AppConstants.radius6)),
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
            onTap: () => controller.saveData(),
            child: Container(
              width: 73,
              height: 40,
              decoration: BoxDecoration(
                  color: Get.theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(AppConstants.radius6)),
              child: Center(
                child: Text(
                  'Save',
                  style:
                      Get.textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }
}

class ToDateSelection extends StatelessWidget {
  const ToDateSelection({
    super.key,
    required this.controller,
  });

  final AddEmployeeController controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: () => controller.showCustomDatePicker(isToDate: true),
        child: TextFormField(
          controller: controller.toDateController,
          style: Get.textTheme.bodyLarge
              ?.copyWith(color: Colors.black, fontSize: 16),
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.event_outlined,
                color: Get.theme.primaryColor,
              ),
              hintText: 'No date',
              hintStyle: Get.textTheme.bodyLarge
                  ?.copyWith(color: Colors.grey, fontSize: 16),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radius4),
                borderSide: BorderSide(color: Get.theme.primaryColor, width: 1),
              ),
              enabled: false),
          validator: (value) {
            if (value?.isEmpty ?? false) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      ),
    );
  }
}

class FromDateSelection extends StatelessWidget {
  const FromDateSelection({
    super.key,
    required this.controller,
  });

  final AddEmployeeController controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: () => controller.showCustomDatePicker(isToDate: false),
        child: TextFormField(
          controller: controller.fromDateController,
          style: Get.textTheme.bodyLarge
              ?.copyWith(color: Colors.black, fontSize: 16),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.event_outlined,
              color: Get.theme.primaryColor,
            ),
            hintText: 'Today',
            enabled: false,
            hintStyle: Get.textTheme.bodyLarge
                ?.copyWith(color: Colors.grey, fontSize: 16),
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.radius4),
              borderSide: BorderSide(color: Get.theme.primaryColor, width: 1),
            ),
          ),
          validator: (value) {
            if (value?.isEmpty ?? false) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      ),
    );
  }
}

class RoleSelection extends StatelessWidget {
  const RoleSelection({
    super.key,
    required this.controller,
  });

  final AddEmployeeController controller;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.showRoleSelectionDialog(),
      child: TextFormField(
        controller: controller.employeeRoleController,
        style: Get.textTheme.bodyLarge
            ?.copyWith(color: Colors.black, fontSize: 16),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.work_outline,
            color: Get.theme.primaryColor,
          ),
          suffixIcon: Icon(
            Icons.arrow_drop_down,
            color: Get.theme.primaryColor,
          ),
          hintText: 'Select role',
          enabled: false,
          hintStyle: Get.textTheme.bodyLarge
              ?.copyWith(color: Colors.grey, fontSize: 16),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.radius4),
            borderSide: BorderSide(color: Get.theme.primaryColor, width: 1),
          ),
        ),
        validator: (value) {
          if (value?.isEmpty ?? false) {
            return 'Please select a role';
          }
          return null;
        },
      ),
    );
  }
}

class EmployeeNameInput extends StatelessWidget {
  const EmployeeNameInput({
    super.key,
    required this.controller,
  });

  final AddEmployeeController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.employeeNameController,
      style:
          Get.textTheme.bodyLarge?.copyWith(color: Colors.black, fontSize: 16),
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person_outline,
            color: Get.theme.primaryColor,
          ),
          hintText: 'Employee name',
          hintStyle: Get.textTheme.bodyLarge
              ?.copyWith(color: Colors.grey, fontSize: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.radius4),
            borderSide: BorderSide(color: Get.theme.primaryColor, width: 1),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0)),
      validator: (value) {
        if (value?.isEmpty ?? false) {
          return 'Please enter a valid name';
        }
        return null;
      },
    );
  }
}
