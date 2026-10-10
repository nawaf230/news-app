import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/widgets/custom_text_form_field.dart';

class ProfileInfoBottomSheet extends StatefulWidget {
  const ProfileInfoBottomSheet({super.key});

  @override
  State<ProfileInfoBottomSheet> createState() => _ProfileInfoBottomSheetState();
}

class _ProfileInfoBottomSheetState extends State<ProfileInfoBottomSheet> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final user = UserRepository().getUser();
    userNameController.text = user?.name ?? '';
    emailController.text = user?.email ?? '';
  }

  void _saveUserData(BuildContext context) async {
    if (_key.currentState!.validate()) {
      await UserRepository().updateUser(name: userNameController.text, email: emailController.text);

      if (!context.mounted) return;

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: AppSizes.h16,
        left: AppSizes.h16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _key,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: AppSizes.h16),
              Center(
                child: Container(
                  height: AppSizes.h4,
                  width: AppSizes.w32,
                  decoration: BoxDecoration(
                    color: Color(0xFF363636),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              SizedBox(height: AppSizes.h16),
              Text(
                'Profile Info',
                style: TextStyle(
                  fontSize: AppSizes.sp16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF141414),
                ),
              ),
              SizedBox(height: AppSizes.h24),
              CustomTextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: userNameController,
                hintText: 'username123',
                title: 'User Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter user name';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppSizes.h24),
              CustomTextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                hintText: 'usama@gmail.com',
                title: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }

                  return null;
                },
              ),
              SizedBox(height: AppSizes.h80),
              ElevatedButton(
                onPressed: () {
                  _saveUserData(context);
                },

                style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, AppSizes.h48)),
                child: Text("Save"),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
