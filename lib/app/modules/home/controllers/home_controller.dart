import 'package:employee_list/app/data/db/employee_data.dart';
import 'package:employee_list/app/data/db/employee_database.dart';
import 'package:employee_list/app/modules/home/cubit/employee_list_cubit.dart';
import 'package:employee_list/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final EmployeeDatabase db = EmployeeDatabase.instance;

  deleteItem(Employee employee, BuildContext context) async {
    await db.delete(employee.id!).then((value) {
      context.read<EmployeeListCubit>().getEmployeeList();
    });
    Get.showSnackbar(const GetSnackBar(
      message: 'Employee data has been deleted',
      dismissDirection: DismissDirection.horizontal,
      duration: Duration(seconds: 1),
    ));
  }

  editEmployee(
    Employee employee,
    BuildContext context,
  ) async {
    Get.toNamed(Routes.ADD_EMPLOYEE, arguments: {'id': employee.id})
        ?.then((value) => context.read<EmployeeListCubit>().getEmployeeList());
  }
}
