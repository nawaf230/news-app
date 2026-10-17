import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    required this.title,
    this.obscureText = false,
    required this.keyboardType,
  });

  final TextEditingController controller;

  // call back Function.
  final String? Function(String?)? validator;
  final String hintText;
  final String title;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 16)),
        const Gap(8),
        TextFormField(
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          controller: widget.controller,
          obscureText: widget.obscureText && !_isVisible,
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                      });
                    },
                    icon: _isVisible
                        ? Icon(Icons.visibility_outlined, color: Color(0xFF363636))
                        : Icon(Icons.visibility_off_outlined, color: Color(0xFF363636)),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
