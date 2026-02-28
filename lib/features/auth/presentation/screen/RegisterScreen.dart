import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(StringsManager.createAccount.tr()),
          backgroundColor: Colors.green,
        ),
      );

      context.pop();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Something went wrong'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

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
          StringsManager.createAccount.tr(),
          style: TextStyle(
            color: const Color(0xFFFFC107),
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.h),

                const AvatarSelector(),

                SizedBox(height: 30.h),

                /// Name
                CustomAuthTextField(
                  hintText: StringsManager.name.tr(),
                  prefixIcon: Icons.badge_outlined,
                  controller: nameController,
                  validator: (v) =>
                  v == null || v.isEmpty ? StringsManager.name.tr() : null,
                ),

                SizedBox(height: 16.h),

                /// Email
                CustomAuthTextField(
                  hintText: StringsManager.email.tr(),
                  prefixIcon: Icons.email,
                  controller: emailController,
                  validator: (v) =>
                  v != null && v.contains('@')
                      ? null
                      : 'Invalid email',
                ),

                SizedBox(height: 16.h),

                /// Password
                CustomAuthTextField(
                  hintText: StringsManager.password.tr(),
                  prefixIcon: Icons.lock,
                  isPassword: true,
                  controller: passwordController,
                  validator: (v) =>
                  v != null && v.length >= 6
                      ? null
                      : 'Password too short',
                ),

                SizedBox(height: 16.h),

                /// Confirm Password
                CustomAuthTextField(
                  hintText: StringsManager.confirmPassword.tr(),
                  prefixIcon: Icons.lock,
                  isPassword: true,
                  controller: confirmPasswordController,
                  validator: (v) =>
                  v == passwordController.text
                      ? null
                      : 'Passwords do not match',
                ),

                SizedBox(height: 16.h),

                /// Phone
                CustomAuthTextField(
                  hintText: StringsManager.phoneNumber.tr(),
                  prefixIcon: Icons.phone,
                  controller: phoneController,
                ),

                SizedBox(height: 30.h),

                /// Create Account Button
                SizedBox(
                  width: double.infinity,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC107),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                      color: Colors.black,
                    )
                        : Text(
                      StringsManager.createAccount.tr(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                /// Already have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsManager.dontHaveAccount.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: Text(
                        StringsManager.login.tr(),
                        style: const TextStyle(
                          color: Color(0xFFFFC107),
                          fontWeight: FontWeight.bold,
                        ),
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
            CircleAvatar(
              radius: 40.r,
              backgroundImage:
              const AssetImage('assets/images/avatar1.png'),
            ),
            SizedBox(width: 10.w),
            CircleAvatar(
              radius: 65.r,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 62.r,
                backgroundImage:
                const AssetImage('assets/images/avatar_main.png'),
              ),
            ),
            SizedBox(width: 10.w),
            CircleAvatar(
              radius: 40.r,
              backgroundImage:
              const AssetImage('assets/images/avatar2.png'),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          StringsManager.avatar.tr(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}