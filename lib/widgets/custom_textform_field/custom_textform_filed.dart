import 'package:admin/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.name,
    required this.labelname, 
  });

  final TextEditingController name;

  final String labelname;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: name,
      decoration: InputDecoration(
        filled: true,
        labelText: labelname,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppClr.gradientcolor2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}