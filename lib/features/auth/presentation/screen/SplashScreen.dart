import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/routing/app_router.dart';
import 'package:movies_app/core/utils/user_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      if (!mounted) return;
      final seen = await UserPreferences.isOnboardingSeen();
      if (!mounted) return;
      if (!seen) {
        context.go(AppRouter.onboarding);
        return;
      }
      final user = FirebaseAuth.instance.currentUser;
      context.go(user != null ? AppRouter.home : AppRouter.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 121.w,
          height: 118.h,
        ),
      ),
    );
  }
}