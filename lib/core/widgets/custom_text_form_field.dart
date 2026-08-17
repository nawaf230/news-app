import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    required this.title,
    this.suffix,
  });

  final TextEditingController controller;

  // call back Function.
  final String? Function(String?)? validator;
  final String hintText;
  final String title;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.displaySmall!.copyWith(fontSize: 16),
        ),
        const Gap(8),
        TextFormField(
          validator: validator,
          controller: controller,
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(hintText: hintText, suffixIcon: suffix),
        ),
      ],
    );
  }
}
