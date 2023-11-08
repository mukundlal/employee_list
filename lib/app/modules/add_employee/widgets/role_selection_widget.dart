import 'package:employee_list/app/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoleSelectionWidget extends StatelessWidget {
  static const roles = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner'
  ];
  const RoleSelectionWidget({super.key, required this.onSelect});
  final Function(String) onSelect;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (ctx, pos) {
          String role = roles[pos];
          return InkWell(
            onTap: () => onSelect(role),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spaceMedium),
              child: Center(
                child: Text(role),
              ),
            ),
          );
        },
        separatorBuilder: (ctx, pos) => const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
        itemCount: roles.length);
  }
}
