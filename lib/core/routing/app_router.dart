import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/features/auth/presentation/screen/LoginScreen.dart';
import 'package:movies_app/features/on_boarding/screen/On_boarding.dart';

import '../../features/auth/presentation/screen/RegisterScreen.dart';
import '../../features/auth/presentation/screen/SplashScreen.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forget-password';
  static const String home = '/home';
  static const String movieDetails = '/movie-details';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: onboarding,
        builder: (context, state) => const OnBoarding(),
      ),

      GoRoute(
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: register,
        builder: (context, state) => const RegisterScreen(),
      ),

      GoRoute(
        path: forgetPassword,
        builder: (context, state) => const Scaffold(body: Center(child: Text('Forget Password Screen'))),
      ),

      GoRoute(
        path: home,
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Home Screen with 4 Tabs')),
        ),
      ),

      GoRoute(
        path: movieDetails,
        builder: (context, state) {
          final movie = state.extra;
          return const Scaffold(body: Center(child: Text('Movie Details Screen')));
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.matchedLocation}')),
    ),
  );
}