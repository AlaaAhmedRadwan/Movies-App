import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/features/auth/presentation/screen/ForgetPasswordScreen.dart';
import 'package:movies_app/features/auth/presentation/screen/LoginScreen.dart';
import 'package:movies_app/features/auth/presentation/screen/SplashScreen.dart';
import 'package:movies_app/features/auth/presentation/screen/UpdateProfileScreen.dart';
import 'package:movies_app/features/home/presentation/screen/HomeScreen.dart';
import 'package:movies_app/features/on_boarding/screen/OnBoarding.dart';

import '../../features/auth/presentation/screen/RegisterScreen.dart';
import '../../features/home/domain/entities/movie.dart';
import '../../features/home/presentation/screen/MovieDetails.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forget-password';
  static const String home = '/home';
  static const String movieDetails = '/movie-details';
  static const String updateProfile = '/update-profile';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
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
        builder: (context, state) => const ForgetPasswordScreen(),
      ),

      GoRoute(
        path: home,
        builder: (context, state) => const Scaffold(
          body: HomeScreen(),
        ),
      ),

      GoRoute(
        path: movieDetails,
        builder: (context, state) {
          final movie = state.extra as Movie;
          return Moviedetails(movie: movie);
        },
      ),

      GoRoute(
        path: updateProfile,
        builder: (context, state) => const UpdateProfileScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Page not found: ${state.matchedLocation}')),
    ),
  );
}