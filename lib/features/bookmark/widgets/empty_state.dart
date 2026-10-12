import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/features/bookmark/cubit/bookmark_cubit.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkCubit, BookmarkState>(
      builder: (BuildContext context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bookmark_border, size: 100, color: Colors.grey.shade300),
              SizedBox(height: AppSizes.h24),
              Text(
                'No bookmarks yet',
                style: TextStyle(
                  fontSize: AppSizes.sp20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: AppSizes.h8),
              Text(
                'Start bookmarking articles to see them here',
                style: TextStyle(fontSize: AppSizes.sp14, color: Colors.grey.shade500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
