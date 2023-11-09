import 'package:employee_list/app/data/db/employee_data.dart';
import 'package:employee_list/app/modules/home/cubit/employee_list_cubit.dart';
import 'package:employee_list/app/modules/home/widgets/empty_widget.dart';
import 'package:employee_list/app/routes/app_pages.dart';
import 'package:employee_list/app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => EmployeeListCubit()..getEmployeeList(),
      child: HomeWidget(controller: controller),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.background,
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: BlocBuilder<EmployeeListCubit, ListDataState>(
          builder: (context, state) {
        switch (state.runtimeType) {
          case HasErrorState:
            return const Center(
              child: Text('Error Happened'),
            );
          case HasDataState:
            final List<Employee> activeList =
                (state as HasDataState).activeList;
            final List<Employee> inActiveList = (state).inActiveList;
            return SizedBox(
              height: Get.height,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (activeList.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(
                                  AppConstants.spaceMedium),
                              child: Text(
                                'Current employees',
                                style: Get.textTheme.bodyLarge?.copyWith(
                                    color: Get.theme.primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                            ),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, pos) => EmployeeItemWidget(
                              employee: activeList[pos],
                            ),
                            itemCount: activeList.length,
                            shrinkWrap: true,
                            separatorBuilder: (_, __) => const Divider(
                              thickness: 0.5,
                              color: Colors.black12,
                              height: 0.5,
                            ),
                          ),
                          if (inActiveList.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.all(
                                  AppConstants.spaceMedium),
                              child: Text(
                                'Previous employees',
                                style: Get.textTheme.bodyLarge?.copyWith(
                                    color: Get.theme.primaryColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                            ),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, pos) => EmployeeItemWidget(
                              employee: inActiveList[pos],
                            ),
                            itemCount: inActiveList.length,
                            shrinkWrap: true,
                            separatorBuilder: (_, __) => const Divider(
                              thickness: 0.5,
                              color: Colors.black12,
                              height: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (activeList.isNotEmpty || inActiveList.isNotEmpty)
                    const SizedBox(
                      height: 66,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 12),
                          child: Text(
                            'Swipe left to delete',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            );
          case IsLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case IsEmptyState:
            return const EmptyWidget();
          default:
            return const Center();
        }
      }),
      floatingActionButton: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.radius8),
            color: Get.theme.primaryColor),
        child: IconButton(
          onPressed: () => Get.toNamed(Routes.ADD_EMPLOYEE)?.then(
              (value) => context.read<EmployeeListCubit>().getEmployeeList()),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class EmployeeItemWidget extends StatelessWidget {
  const EmployeeItemWidget({super.key, required this.employee});
  final Employee employee;

  @override
  Widget build(BuildContext context) {
    String dateRangeText = (employee.isEmployeeActive)
        ? 'From ${employee.startDate}'
        : '${employee.startDate} - ${employee.endDate}';
    final HomeController controller = Get.find();

    return Dismissible(
      key: Key(employee.id.toString()),
      secondaryBackground: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ),
      background: Container(
        color: Colors.blue,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.edit, color: Colors.white),
          ),
        ),
      ),
      child: Container(
        color: Colors.white,
        child: ListTile(
          contentPadding: const EdgeInsets.all(AppConstants.spaceMedium),
          title: Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.spaceSmall),
            child: Text(
              employee.name,
              style: Get.textTheme.bodyMedium
                  ?.copyWith(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                employee.role,
                style: Get.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: AppConstants.spaceSmall,
              ),
              Text(
                dateRangeText,
                style: Get.textTheme.bodyMedium
                    ?.copyWith(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          await controller.editEmployee(employee, context);
          return false;
        } else if (direction == DismissDirection.endToStart) {
          {
            await controller.deleteItem(employee, context);
            return false;
          }
        }
        return null;
      },
    );
  }
}
