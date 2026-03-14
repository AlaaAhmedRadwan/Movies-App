import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/di/get_it.dart';
import 'package:movies_app/core/resources/AssetsManager.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';
import 'package:movies_app/core/routing/app_router.dart';
import 'package:movies_app/core/strings_manager/AppStrings.dart';
import 'package:movies_app/core/utils/user_preferences.dart';
import 'package:movies_app/features/home/data/services/firebase_movies_service.dart';
import 'package:movies_app/features/home/domain/entities/movie.dart';
import 'package:movies_app/features/home/domain/entities/history_movie.dart';
import 'package:movies_app/features/home/domain/entities/wishlist_movie.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _savedAvatar;
  final _service = sl<FirebaseMoviesService>();

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
                            _buildWishlistStat(),
                            _buildHistoryStat(),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  Text(
                    user?.displayName ?? AppStrings.profileMovieFan.tr(),
                    style: TextStyle(
                      color: ColorsManager.SecondaryColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 16.h),

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
                          icon: Icon(Icons.logout_rounded,
                              color: Colors.white, size: 18.sp),
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

            TabBar(
              controller: _tabController,
              indicatorColor: ColorsManager.onPrimaryColor,
              indicatorWeight: 3,
              labelColor: ColorsManager.SecondaryColor,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                    icon: const Icon(Icons.format_list_bulleted_rounded),
                    text: AppStrings.profileWatchList.tr()),
                Tab(
                    icon: const Icon(Icons.folder_rounded),
                    text: AppStrings.profileHistory.tr()),
              ],
            ),

            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildWishlistTab(),
                  _buildHistoryTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Stats ──────────────────────────────────────────────────────────────────

  Widget _buildWishlistStat() {
    return StreamBuilder<List<WishlistMovie>>(
      stream: _service.getWishlist(),
      builder: (context, snap) {
        final count = snap.data?.length ?? 0;
        return _buildStat(count.toString(), AppStrings.profileWatchList.tr());
      },
    );
  }

  Widget _buildHistoryStat() {
    return StreamBuilder(
      stream: _service.getHistory(),
      builder: (context, snap) {
        final count = snap.data?.length ?? 0;
        return _buildStat(count.toString(), AppStrings.profileHistory.tr());
      },
    );
  }

  // ── Wishlist Tab ───────────────────────────────────────────────────────────

  Widget _buildWishlistTab() {
    return StreamBuilder<List<WishlistMovie>>(
      stream: _service.getWishlist(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final movies = snapshot.data ?? [];

        if (movies.isEmpty) {
          return _buildEmptyState();
        }

        return GridView.builder(
          padding: EdgeInsets.all(12.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.h,
            childAspectRatio: 0.65,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) =>
              _buildWishlistItem(movies[index]),
        );
      },
    );
  }

  Widget _buildWishlistItem(WishlistMovie item) {
    return GestureDetector(
      onTap: () {
        final movie = Movie(
          id: item.id,
          title: item.title,
          poster: item.poster,
          year: item.year,
          rating: 0.0,
          runtime: 0,
          genres: [],
          summary: '',
        );
        context.push(AppRouter.movieDetails, extra: movie);
      },
      onLongPress: () => _confirmRemove(item),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                imageUrl: item.poster,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (_, __) => Container(
                  color: ColorsManager.onSecondaryColor,
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: ColorsManager.onSecondaryColor,
                  child: const Icon(Icons.movie,
                      color: Colors.white54, size: 32),
                ),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            item.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: ColorsManager.SecondaryColor,
              fontSize: 11.sp,
            ),
          ),
          Text(
            item.year.toString(),
            style: TextStyle(color: Colors.grey, fontSize: 10.sp),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmRemove(WishlistMovie item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: ColorsManager.onSecondaryColor,
        title: Text(item.title,
            style: const TextStyle(color: ColorsManager.SecondaryColor)),
        content: const Text('Remove from wishlist?',
            style: TextStyle(color: Colors.grey)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(AppStrings.profileCancel.tr(),
                style: const TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Remove',
                style: TextStyle(color: ColorsManager.teritaryColor)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await _service.removeFromWishlist(item.id);
    }
  }

  // ── History Tab ───────────────────────────────────────────────────────────

  Widget _buildHistoryTab() {
    return StreamBuilder<List<HistoryMovie>>(
      stream: _service.getHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final movies = snapshot.data ?? [];

        if (movies.isEmpty) {
          return _buildEmptyState();
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          itemCount: movies.length,
          itemBuilder: (context, index) => _buildHistoryItem(movies[index]),
        );
      },
    );
  }

  Widget _buildHistoryItem(HistoryMovie item) {
    return GestureDetector(
      onTap: () {
        final movie = Movie(
          id: item.id,
          title: item.title,
          poster: item.poster,
          year: 0,
          rating: 0.0,
          runtime: 0,
          genres: [],
          summary: '',
        );
        context.push(AppRouter.movieDetails, extra: movie);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          color: ColorsManager.onSecondaryColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
              child: CachedNetworkImage(
                imageUrl: item.poster,
                width: 70.w,
                height: 90.h,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  width: 70.w,
                  height: 90.h,
                  color: Colors.grey[800],
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (_, __, ___) => Container(
                  width: 70.w,
                  height: 90.h,
                  color: Colors.grey[800],
                  child: const Icon(Icons.movie, color: Colors.white54),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ColorsManager.SecondaryColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(Icons.access_time,
                          size: 12.sp, color: Colors.grey),
                      SizedBox(width: 4.w),
                      Text(
                        _formatDate(item.watchedAt),
                        style:
                            TextStyle(color: Colors.grey, fontSize: 11.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}  ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  Widget _buildAvatar(User? user) {
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
      child: Icon(Icons.person,
          size: 48.sp, color: ColorsManager.onPrimaryColor),
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
        Text(label,
            style: TextStyle(color: Colors.grey, fontSize: 13.sp)),
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
        title: Text(AppStrings.profileSignOutTitle.tr(),
            style: const TextStyle(color: ColorsManager.SecondaryColor)),
        content: Text(AppStrings.profileSignOutMessage.tr(),
            style: const TextStyle(color: Colors.grey)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(AppStrings.profileCancel.tr(),
                style: const TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(AppStrings.profileSignOut.tr(),
                style:
                    const TextStyle(color: ColorsManager.teritaryColor)),
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
