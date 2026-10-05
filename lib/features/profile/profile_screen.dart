import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/local_data/preferences_manager.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/custom_svg_picture.dart';
import 'package:news_app/features/auth/login_screen.dart';
import 'package:news_app/features/profile/bottom_sheet/profile_info_bottom_sheet.dart';
import 'package:news_app/features/profile/profile_controller.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileController>(
      create: (BuildContext context) => ProfileController()..init(),

      child: Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: Center(
          child: Consumer<ProfileController>(
            builder: (context, controller, child) {
              return Align(
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: AppSizes.h28),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          border: Border.all(color: Color(0xFFD1DAD6), width: AppSizes.r1),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomRight,

                          children: [
                            CircleAvatar(
                              backgroundImage: controller.selectedFile == null
                                  ? AssetImage('assets/images/person.png')
                                  : FileImage(File(controller.selectedFile!.path)),
                              backgroundColor: LightColors.backgroundColor,
                              radius: AppSizes.r43,
                            ),
                            GestureDetector(
                              onTap: () async {
                                _showImageSourceDialog(context);
                              },
                              child: Container(
                                width: AppSizes.w34,
                                height: AppSizes.h34,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(AppSizes.r100),
                                  border: Border.all(color: Color(0xFFD1DAD6)),
                                ),
                                child: Icon(
                                  size: AppSizes.r26,
                                  Icons.camera_alt_outlined,
                                  weight: AppSizes.w15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppSizes.h8),
                      Text(
                        controller.userName.toString(),
                        style: TextStyle(
                          fontSize: AppSizes.sp16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF161F1B),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.w16,
                          vertical: AppSizes.h16,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Profile Info',
                              style: TextStyle(
                                fontSize: AppSizes.sp14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF161F1B),
                              ),
                            ),
                            _buildItem(
                              title: 'Personal Info',
                              path: 'assets/images/person.svg',
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: LightColors.backgroundColor,
                                  isDismissible: false,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return ProfileInfoBottomSheet();
                                  },
                                ).then((value) {
                                  controller.getUserData();
                                });
                              },
                            ),
                            _buildItem(
                              title: 'Language',
                              path: 'assets/images/network.svg',
                              onTap: () {},
                            ),
                            _buildItem(
                              title: controller.countryCode ?? 'Country',
                              path: 'assets/images/flag.svg',
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  // showPhoneCode: true,
                                  // optional. Shows phone code before the country name.
                                  onSelect: (Country country) {
                                    controller.saveCountry(country);
                                  },
                                  favorite: ['PS', 'EG'],
                                );
                              },
                            ),
                            _buildItem(
                              title: 'Terms & Conditions',
                              path: 'assets/images/file.svg',
                              onTap: () {},
                            ),
                            _buildItem(
                              title: 'Logout',
                              path: 'assets/images/log_out.svg',
                              onTap: () async {
                                await PreferencesManager().clear();
                                if (!context.mounted) return;
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginScreen()),
                                );
                              },
                              color: LightColors.primaryColor,
                              isDivider: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    final controller = context.read<ProfileController>();

    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("choose Image Source", style: Theme.of(context).textTheme.titleMedium),
          children: [
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                controller.pickImage(ImageSource.camera);
              },
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: AppSizes.w8),
                  Text("Camera"),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context);
                controller.pickImage(ImageSource.gallery);
              },
              child: Row(
                children: [
                  Icon(Icons.photo_library_outlined),
                  SizedBox(width: AppSizes.w8),
                  Text("Gallery"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildItem({
    required String title,
    required String path,
    Color color = const Color(0xFF161F1B),
    required Function onTap,
    bool isDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: () => onTap(),
          title: Text(
            title,
            style: TextStyle(fontSize: AppSizes.sp16, fontWeight: FontWeight.w400, color: color),
          ),
          leading: CustomSvgPicture.withoutColor(path: path),
          trailing: CustomSvgPicture(path: 'assets/images/arrow_right.svg', colorFilter: color),

          contentPadding: EdgeInsets.zero,
        ),
        if (isDivider) Divider(),
      ],
    );
  }

  void showKeyboardSafeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // ضروري عشان الشيت تاخد المساحة الصح مع الكيبورد
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          // ده اللي بيدفع المحتوى لفوق لما الكيبورد يظهر
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'أضف تعليق',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'اكتب هنا...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('إرسال'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
