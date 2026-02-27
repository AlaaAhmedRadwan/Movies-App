import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/resources/StringsManager.dart';

import '../widgets/CustomAuthTextField.dart';
import '../widgets/LanguageToggle.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFFC107)),
          onPressed: () => context.pop(),
        ),
        title: Text(
          StringsManager.createAccount,
          style: TextStyle(color: const Color(0xFFFFC107), fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              const AvatarSelector(),
              SizedBox(height: 30.h),

              CustomAuthTextField(hintText: StringsManager.name, prefixIcon: Icons.badge_outlined),
              SizedBox(height: 16.h),
              CustomAuthTextField(hintText: StringsManager.email, prefixIcon: Icons.email),
              SizedBox(height: 16.h),
              CustomAuthTextField(hintText: StringsManager.password, prefixIcon: Icons.lock, isPassword: true),
              SizedBox(height: 16.h),
              CustomAuthTextField(hintText: StringsManager.confirmPassword, prefixIcon: Icons.lock, isPassword: true),
              SizedBox(height: 16.h),
              CustomAuthTextField(hintText: StringsManager.phoneNumber, prefixIcon: Icons.phone),

              SizedBox(height: 30.h),

              // Create Account Button
              SizedBox(
                width: double.infinity,
                height: 55.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
                  ),
                  child: Text(
                    StringsManager.createAccount,
                    style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Already Have Account Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(StringsManager.dontHaveAccount, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: Text(
                      StringsManager.login,
                      style: TextStyle(color: const Color(0xFFFFC107), fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),
              const LanguageToggle(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}

class AvatarSelector extends StatelessWidget {
  const AvatarSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(radius: 40.r, backgroundImage: const AssetImage('assets/images/avatar1.png')),
            SizedBox(width: 10.w),
            CircleAvatar(
              radius: 65.r,
              backgroundColor: Colors.white,
              child: CircleAvatar(radius: 62.r, backgroundImage: const AssetImage('assets/images/avatar_main.png')),
            ),
            SizedBox(width: 10.w),
            CircleAvatar(radius: 40.r, backgroundImage: const AssetImage('assets/images/avatar2.png')),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          StringsManager.avatar,
          style: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
      ],
    );
  }
}