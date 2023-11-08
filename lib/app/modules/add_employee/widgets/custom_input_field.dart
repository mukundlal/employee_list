import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const CustomTextFormField({super.key,
    required this.hintText,
    required this.prefixIcon,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
        ),
      ),
      validator: validator ??
              (value) {
            if (value?.isEmpty ?? false) {
              return 'Please enter some text';
            }
            return null;
          },
    );
  }
}
