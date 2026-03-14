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
import 'package:movies_app/features/auth/presentation/widgets/CustomAuthTextField.dart';

import '../../../../core/resources/StringsManager.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  // avatar asset picked by user; null means use Google photo or icon
  String? _selectedAvatar;

  final List<String> _avatars = [
    Assetsmanager.avatar1,
    Assetsmanager.avatar2,
    Assetsmanager.avatar3,
  ];

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    _nameController.text = user?.displayName ?? '';
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final avatar = await UserPreferences.loadAvatar();
    final phone = await UserPreferences.loadPhone();
    if (!mounted) return;
    setState(() {
      _selectedAvatar = avatar;
      if (phone != null) _phoneController.text = phone;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: ColorsManager.PrimaryColor,
      appBar: AppBar(
        backgroundColor: ColorsManager.PrimaryColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: ColorsManager.onPrimaryColor),
        ),
        title: Text(
          AppStrings.updateProfileTitle.tr(),
          style: TextStyle(
            color: ColorsManager.onPrimaryColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),

            // Avatar picker
            Center(
              child: GestureDetector(
                onTap: () => _showAvatarPicker(context),
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60.r,
                      backgroundColor: ColorsManager.onSecondaryColor,
                      backgroundImage: _selectedAvatar != null
                          ? AssetImage(_selectedAvatar!) as ImageProvider
                          : (user?.photoURL != null
                              ? NetworkImage(user!.photoURL!)
                              : null),
                      child: (_selectedAvatar == null && user?.photoURL == null)
                          ? Icon(Icons.person,
                              size: 64.sp,
                              color: ColorsManager.onPrimaryColor)
                          : null,
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        padding: EdgeInsets.all(4.r),
                        decoration: const BoxDecoration(
                          color: ColorsManager.onPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.edit, size: 14.sp,
                            color: ColorsManager.PrimaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 32.h),

            // Name field
            CustomAuthTextField(
              hintText: AppStrings.updateProfileNameHint.tr(),
              prefixIcon: Icons.person_outline,
              controller: _nameController,
            ),

            SizedBox(height: 16.h),

            // Phone field
            CustomAuthTextField(
              hintText: AppStrings.updateProfilePhoneHint.tr(),
              prefixIcon: Icons.phone_outlined,
              controller: _phoneController,
            ),

            SizedBox(height: 20.h),

            // Reset Password link
            GestureDetector(
              onTap: () => _sendPasswordReset(context, user),
              child: Text(
                AppStrings.updateProfileResetPassword.tr(),
                style: TextStyle(
                  color: ColorsManager.SecondaryColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: 160.h),

            // Delete Account button
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton(
                onPressed: _isLoading ? null : () => _confirmDeleteAccount(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.teritaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  AppStrings.updateProfileDeleteAccount.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: 12.h),

            // Update Data button
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton(
                onPressed: _isLoading ? null : () => _updateProfile(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.onPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.black)
                    : Text(
                        AppStrings.updateProfileUpdateData.tr(),
                        style: TextStyle(
                          color: ColorsManager.PrimaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  void _showAvatarPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.onSecondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.updateProfileTitle.tr(),
              style: TextStyle(
                color: ColorsManager.SecondaryColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _avatars
                  .map(
                    (avatar) => GestureDetector(
                      onTap: () {
                        setState(() => _selectedAvatar = avatar);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _selectedAvatar == avatar
                                ? ColorsManager.onPrimaryColor
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 40.r,
                          backgroundImage: AssetImage(avatar),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Future<void> _updateProfile(BuildContext context) async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final messenger = ScaffoldMessenger.of(context);
    setState(() => _isLoading = true);
    try {
      await Future.wait([
        FirebaseAuth.instance.currentUser?.updateDisplayName(name) ?? Future.value(),
        if (_selectedAvatar != null) UserPreferences.saveAvatar(_selectedAvatar!),
        UserPreferences.savePhone(_phoneController.text.trim()),
      ]);
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(AppStrings.updateProfileSuccess.tr()),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text(e.toString().tr()), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _sendPasswordReset(BuildContext context, User? user) async {
    if (user?.email == null) return;
    final messenger = ScaffoldMessenger.of(context);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: user!.email!);
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(StringsManager.passwordresetemailsent.tr()),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text(e.toString().tr()), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _confirmDeleteAccount(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ColorsManager.onSecondaryColor,
        title: Text(AppStrings.updateProfileDeleteTitle.tr(),
            style: const TextStyle(color: ColorsManager.SecondaryColor)),
        content: Text(
          AppStrings.updateProfileDeleteMessage.tr(),
          style: const TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(AppStrings.profileCancel.tr(), style: const TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(AppStrings.updateProfileDelete.tr(),
                style: const TextStyle(color: ColorsManager.teritaryColor)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await FirebaseAuth.instance.currentUser?.delete();
        if (!mounted) return;
        router.go(AppRouter.login);
      } catch (e) {
        if (!mounted) return;
        messenger.showSnackBar(
          SnackBar(content: Text(e.toString().tr()), backgroundColor: Colors.red),
        );
      }
    }
  }
}
