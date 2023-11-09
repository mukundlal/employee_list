import 'package:employee_list/app/data/db/employee_data.dart';
import 'package:employee_list/app/modules/add_employee/widgets/custom_date_picker.dart';
import 'package:employee_list/app/modules/add_employee/widgets/role_selection_widget.dart';
import 'package:employee_list/app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/db/employee_database.dart';

class AddEmployeeController extends GetxController {
  final TextEditingController employeeNameController = TextEditingController();
  final TextEditingController employeeRoleController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();
  final EmployeeDatabase db = EmployeeDatabase.instance;
  final Map<String, dynamic>? arguments = Get.arguments;
  bool isEdit = false;
  int employeeId = -1;

  @override
  void onInit() {
    if (arguments != null) {
      getUserDetails();
    }
    super.onInit();
  }

  showCustomDatePicker({required bool isToDate}) {
    Get.dialog(CustomDatePicker(
        onDateSelected: (selectedDate) {
          if (isToDate) {
            toDateController.text =
                DateFormat('dd MMM, yyyy').format(selectedDate);
          } else {
            fromDateController.text =
                DateFormat('dd MMM, yyyy').format(selectedDate);
          }
        },
        isToDate: isToDate));
  }

  showRoleSelectionDialog() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppConstants.radius16),
                topRight: Radius.circular(AppConstants.radius16))),
        child: RoleSelectionWidget(onSelect: (role) {
          employeeRoleController.text = role;
          Get.back();
        }),
      ),
    );
  }

  saveData() async {
    if (employeeRoleController.text.isEmpty ||
        employeeNameController.text.isEmpty ||
        fromDateController.text.isEmpty) {
      String errorMessage = '';

      if (employeeRoleController.text.isEmpty) {
        errorMessage += "Employee Role is required.\n";
      }

      if (employeeNameController.text.isEmpty) {
        errorMessage += "Employee Name is required.\n";
      }

      if (fromDateController.text.isEmpty) {
        errorMessage += "From Date is required.\n";
      }
      Get.showSnackbar(GetSnackBar(
        title: 'Please fill all details',
        message: errorMessage,
      ));
      return;
    }
    final Employee employee = Employee(
        id: isEdit ? employeeId : null,
        name: employeeNameController.text,
        role: employeeRoleController.text,
        startDate: fromDateController.text,
        isEmployeeActive: toDateController.text.isEmpty,
        endDate: toDateController.text);
    late GetSnackBar snackBar;
    if (isEdit) {
      await db.update(employee);
      snackBar = const GetSnackBar(
        title: 'Success',
        message: 'Employee data updated',
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(seconds: 1),
      );
    } else {
      await db.create(employee);
      snackBar = const GetSnackBar(
        title: 'Success',
        message: 'Employee data created',
        dismissDirection: DismissDirection.horizontal,
        duration: Duration(seconds: 1),
      );
    }

    Get.back();
    Get.showSnackbar(snackBar);
  }

  void getUserDetails() async {
    isEdit = true;
    employeeId = arguments?['id'];
    Employee? employee = await db.readEmployee(employeeId);
    if (employee != null) {
      employeeRoleController.text = employee.role;
      employeeNameController.text = employee.name;
      fromDateController.text = employee.startDate;
      toDateController.text = employee.endDate ?? '';
    }
  }

  deleteEmployee() {
    db.delete(employeeId).then((value) {
      Get.back();
      Get.showSnackbar(const GetSnackBar(
        message: 'Employee data has been deleted',
        dismissDirection: DismissDirection.horizontal,
      ));
    });
  }
}
