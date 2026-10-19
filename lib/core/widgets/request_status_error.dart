import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';

class RequestStatusError extends StatelessWidget {
  const RequestStatusError({super.key, required this.onPressed, this.errorMessage});

  final void Function()? onPressed;

  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          SizedBox(height: AppSizes.h16),
          Text(errorMessage!, style: TextStyle(fontSize: AppSizes.sp16)),
          SizedBox(height: AppSizes.h16),
          ElevatedButton(onPressed: onPressed, child: const Text('Retry')),
        ],
      ),
    );
  }
}
