import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/resources/AssetsManager.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';
import 'package:movies_app/core/routing/app_router.dart';
import 'package:movies_app/core/strings_manager/AppStrings.dart';
import 'package:movies_app/core/utils/user_preferences.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _savedAvatar;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadAvatar();
  }

  Future<void> _loadAvatar() async {
    final avatar = await UserPreferences.loadAvatar();
    if (!mounted) return;
    setState(() => _savedAvatar = avatar);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadAvatar();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: ColorsManager.PrimaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar + Stats
                  Row(
                    children: [
                      _buildAvatar(user),
                      SizedBox(width: 28.w),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStat('12', 'Wish List'),
                            _buildStat('10', 'History'),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Name
                  Text(
                    user?.displayName ?? AppStrings.profileMovieFan.tr(),
                    style: TextStyle(
                      color: ColorsManager.SecondaryColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Edit Profile + Exit buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await context.push(AppRouter.updateProfile);
                            _loadAvatar();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.onPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                          ),
                          child: Text(
                            AppStrings.profileEditProfile.tr(),
                            style: TextStyle(
                              color: ColorsManager.PrimaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _confirmSignOut(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.teritaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                          ),
                          icon: Icon(
                            Icons.logout_rounded,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                          label: Text(
                            AppStrings.profileSignOut.tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),
                ],
              ),
            ),

            // Tab bar
            TabBar(
              controller: _tabController,
              indicatorColor: ColorsManager.onPrimaryColor,
              indicatorWeight: 3,
              labelColor: ColorsManager.SecondaryColor,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(icon: const Icon(Icons.format_list_bulleted_rounded), text: AppStrings.profileWatchList.tr()),
                Tab(icon: const Icon(Icons.folder_rounded), text: AppStrings.profileHistory.tr()),
              ],
            ),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildEmptyState(),
                  _buildEmptyState(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(User? user) {
    // saved local avatar takes priority
    if (_savedAvatar != null) {
      return CircleAvatar(
        radius: 45.r,
        backgroundImage: AssetImage(_savedAvatar!),
        backgroundColor: ColorsManager.onSecondaryColor,
      );
    }
    if (user?.photoURL != null) {
      return CircleAvatar(
        radius: 45.r,
        backgroundImage: NetworkImage(user!.photoURL!),
        backgroundColor: ColorsManager.onSecondaryColor,
      );
    }
    return CircleAvatar(
      radius: 45.r,
      backgroundColor: ColorsManager.onSecondaryColor,
      child: Icon(
        Icons.person,
        size: 48.sp,
        color: ColorsManager.onPrimaryColor,
      ),
    );
  }

  Widget _buildStat(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            color: ColorsManager.SecondaryColor,
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 13.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Image.asset(
        Assetsmanager.Available,
        width: 160.w,
        height: 160.h,
      ),
    );
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ColorsManager.onSecondaryColor,
        title: Text(
          AppStrings.profileSignOutTitle.tr(),
          style: const TextStyle(color: ColorsManager.SecondaryColor),
        ),
        content: Text(
          AppStrings.profileSignOutMessage.tr(),
          style: const TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              AppStrings.profileCancel.tr(),
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(
              AppStrings.profileSignOut.tr(),
              style: const TextStyle(color: ColorsManager.teritaryColor),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) context.go(AppRouter.login);
    }
  }
}
