import 'package:employee_list/app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    required this.onDateSelected,
    required this.isToDate,
  });
  final Function(DateTime) onDateSelected;
  final bool isToDate;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(AppConstants.radius16)),
        ),
        contentPadding: const EdgeInsets.only(top: 10.0),
        content: Container(
          width: Get.width * 0.90,
          padding: const EdgeInsets.all(AppConstants.spaceMedium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.isToDate
                  ? ToDateDialogHeader(
                      selectedDate: (date) {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                      inputDate: selectedDate,
                    )
                  : FromDateDialogHeader(
                      selectedDate: (date) {
                        setState(() {
                          selectedDate = date;
                        });
                      },
                      inputDate: selectedDate,
                    ),
              CalendarDatePicker(
                initialDate: selectedDate,
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
                currentDate: null,
                onDateChanged: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
              DialogFooterWidget(
                  selectedDate: selectedDate,
                  onSubmit: () {
                    widget.onDateSelected(selectedDate);
                    Get.back();
                  })
            ],
          ),
        ),
      );
    });
  }
}

class DialogFooterWidget extends StatelessWidget {
  const DialogFooterWidget({
    super.key,
    required this.selectedDate,
    required this.onSubmit,
  });
  final Function() onSubmit;
  final DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.event_outlined,
              color: Get.theme.primaryColor,
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
                selectedDate != null
                    ? DateFormat('dd MMM yyyy').format(selectedDate!)
                    : 'No date',
                style: Get.textTheme.bodyMedium)
          ],
        ),
        Row(
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
              onTap: () => onSubmit(),
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
          ],
        ),
      ],
    );
  }
}

class FromDateDialogHeader extends StatelessWidget {
  const FromDateDialogHeader(
      {super.key, required this.inputDate, required this.selectedDate});
  final DateTime inputDate;
  final Function(DateTime) selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => selectedDate(DateTime.now()),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Get.theme.colorScheme.secondary,
                      borderRadius:
                          BorderRadius.circular(AppConstants.radius6)),
                  child: Center(
                    child: Text(
                      'Today',
                      style: Get.textTheme.bodyMedium
                          ?.copyWith(color: Get.theme.colorScheme.primary),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: AppConstants.spaceMedium,
            ),
            Expanded(
              child: InkWell(
                onTap: () =>
                    selectedDate(inputDate.add(const Duration(days: 8))),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Get.theme.colorScheme.secondary,
                      borderRadius:
                          BorderRadius.circular(AppConstants.radius6)),
                  child: Center(
                    child: Text(
                      'Next ${DateFormat.EEEE().format(inputDate.add(const Duration(days: 1)))}',
                      style: Get.textTheme.bodyMedium
                          ?.copyWith(color: Get.theme.colorScheme.primary),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: AppConstants.spaceMedium,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: InkWell(
                onTap: () =>
                    selectedDate(inputDate.add(const Duration(days: 9))),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Get.theme.colorScheme.secondary,
                      borderRadius:
                          BorderRadius.circular(AppConstants.radius6)),
                  child: Center(
                    child: Text(
                      'Next ${DateFormat.EEEE().format(inputDate.add(const Duration(days: 2)))}',
                      style: Get.textTheme.bodyMedium
                          ?.copyWith(color: Get.theme.colorScheme.primary),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: AppConstants.spaceMedium,
            ),
            Expanded(
              child: InkWell(
                onTap: () =>
                    selectedDate(inputDate.add(const Duration(days: 7))),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Get.theme.colorScheme.secondary,
                      borderRadius:
                          BorderRadius.circular(AppConstants.radius6)),
                  child: Center(
                    child: Text(
                      'After 1 Week',
                      style: Get.textTheme.bodyMedium
                          ?.copyWith(color: Get.theme.colorScheme.primary),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ToDateDialogHeader extends StatelessWidget {
  const ToDateDialogHeader(
      {super.key, required this.inputDate, required this.selectedDate});
  final DateTime inputDate;
  final Function(DateTime) selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => selectedDate(inputDate),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Get.theme.colorScheme.secondary,
                      borderRadius:
                          BorderRadius.circular(AppConstants.radius6)),
                  child: Center(
                    child: Text(
                      'No date',
                      style: Get.textTheme.bodyMedium
                          ?.copyWith(color: Get.theme.colorScheme.primary),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: AppConstants.spaceMedium,
            ),
            Expanded(
              child: InkWell(
                onTap: () => selectedDate(DateTime.now()),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: Get.theme.colorScheme.secondary,
                      borderRadius:
                          BorderRadius.circular(AppConstants.radius6)),
                  child: Center(
                    child: Text(
                      'Today',
                      style: Get.textTheme.bodyMedium
                          ?.copyWith(color: Get.theme.colorScheme.primary),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
