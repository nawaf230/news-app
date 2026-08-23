import 'package:flutter/material.dart';

class ViewAllComponents extends StatelessWidget {
  const ViewAllComponents({super.key, required this.title, this.titleColor, required this.onTap});

  final String title;
  final Color? titleColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: titleColor ?? Color(0xFFFFFCFC),
            ),
          ),
          InkWell(
            onTap: () => onTap(),
            child: Text(
              'View all',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: titleColor ?? Color(0xFFFFFCFC),
                decoration: TextDecoration.underline,
                decorationColor: titleColor ?? Color(0xFFFFFCFC),
                decorationThickness: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
