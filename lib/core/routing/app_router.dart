import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/resources/StringsManager.dart';
import 'package:movies_app/features/auth/presentation/screen/ForgetPasswordScreen.dart';
import 'package:movies_app/features/auth/presentation/screen/LoginScreen.dart';
import 'package:movies_app/features/auth/presentation/screen/UpdateProfileScreen.dart';
import 'package:movies_app/features/home/presentation/Tabs/Browse/screen/Browse_tab.dart';
import 'package:movies_app/features/home/presentation/Tabs/Search/screen/SearchTab.dart';
import 'package:movies_app/features/home/presentation/screen/HomeScreen.dart';
import 'package:movies_app/features/on_boarding/screen/OnBoarding.dart';

import '../../features/auth/presentation/screen/RegisterScreen.dart';
import '../../features/home/domain/entities/movie.dart';
import '../../features/home/presentation/cubit/movies_cubit.dart';
import '../../features/home/presentation/screen/MovieDetails.dart';
import '../di/get_it.dart';
import '../utils/user_preferences.dart';

class AppRouter {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forget-password';
  static const String home = '/home';
  static const String movieDetails = '/movie-details';
  static const String updateProfile = '/update-profile';
  static const String browse = '/browse';
  static const String search = '/search';
  static final GoRouter router = GoRouter(
    initialLocation: onboarding,
    redirect: (context, state) async {
      final seen = await UserPreferences.isOnboardingSeen();
      final user = FirebaseAuth.instance.currentUser;

      final location = state.matchedLocation;

      if (!seen && location != onboarding) {
        return onboarding;
      }

      if (seen && user == null &&
          location != login &&
          location != register &&
          location != forgetPassword) {
        return login;
      }

      return null;
    },
    routes: [
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
      GoRoute(
        path: browse,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<MoviesCubit>()..getMovies(),
          child: const BrowseTab(),
        ),
      ),
      GoRoute(
        path: search,
        builder: (context, state) =>  SearchTab(),
      ),


    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text("${StringsManager.pagenotfound.tr()} ${state.matchedLocation}")),
    ),
  );
}