import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:movies_app/core/utils/validators.dart';
import 'package:movies_app/features/auth/presentation/widgets/LanguageToggle.dart';
import '../../../../core/strings_manager/AppStrings.dart';
import '../widgets/CustomAuthTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLoginPressed() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      context.go('/home');
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Login failed'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 80.h),

                Image.asset(
                  'assets/images/logo.png',
                  height: 150.h,
                ),

                SizedBox(height: 40.h),

                /// Email
                CustomAuthTextField(
                  hintText: AppStrings.email.tr(),
                  prefixIcon: Icons.email,
                  controller: emailController,
                  validator: Validators.email,
                ),

                SizedBox(height: 16.h),

                /// Password
                CustomAuthTextField(
                  hintText: AppStrings.password.tr(),
                  prefixIcon: Icons.lock,
                  isPassword: true,
                  controller: passwordController,
                  validator: Validators.password,
                  suffixIcon: Icon(
                    Icons.visibility_off,
                    color: Colors.grey,
                    size: 20.sp,
                  ),
                ),

                /// Forget Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {

                    },
                    child: Text(
                      AppStrings.forgetPassword.tr(),
                      style: const TextStyle(
                        color: Color(0xFFFFC107),
                      ),
                    ),
                  ),
                ),

                /// Login Button
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _onLoginPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC107),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                      color: Colors.black,
                    )
                        : Text(
                      AppStrings.login.tr(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                /// Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.dontHaveAccount.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.push('/register'),
                      child: Text(
                        AppStrings.createAccount.tr(),
                        style: TextStyle(
                          color: const Color(0xFFFFC107),
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                /// OR
                Row(
                  children: [
                    const Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        AppStrings.or.tr(),
                        style: TextStyle(
                          color: const Color(0xFFFFC107),
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),

                SizedBox(height: 16.h),

                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/images/google_ic.png',
                      height: 20.h,
                    ),
                    label: Text(
                      AppStrings.loginWithGoogle.tr(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC107),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                const LanguageToggle(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}