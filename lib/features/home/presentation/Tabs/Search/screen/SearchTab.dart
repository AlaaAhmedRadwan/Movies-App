import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';
import 'package:movies_app/features/auth/presentation/widgets/CustomAuthTextField.dart';
import 'package:movies_app/features/home/presentation/cubit/search_cubit.dart';
import 'package:movies_app/features/home/presentation/cubit/search_state.dart';

import '../../../../../../core/resources/StringsManager.dart';
import '../widget/MovieGrid.dart';

class SearchTab extends StatefulWidget {
  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<SearchCubit>().search(value);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.PrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                height: 55.h,
                child: CustomAuthTextField(
                  hintText: StringsManager.searchmovies.tr(),
                  prefixIcon: Icons.search_outlined,
                  controller: _controller,
                  onChanged: _onChanged,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (_controller.text.isEmpty || state is SearchInitial) {
                    return _emptyPrompt();
                  }
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.SecondaryColor,
                      ),
                    );
                  }
                  if (state is SearchLoaded) {
                    return MovieGrid(movies: state.movies);
                  }
                  if (state is SearchEmpty) {
                    return Center(
                      child: Text(
                        StringsManager.noresultsfound.tr(),
                        style: TextStyle(color: Colors.white54, fontSize: 16.sp),
                      ),
                    );
                  }
                  if (state is SearchError) {
                    return Center(
                      child: Text(
                        state.message.tr(),
                        style: TextStyle(color: Colors.red, fontSize: 14.sp),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return _emptyPrompt();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyPrompt() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search, size: 80.sp, color: Colors.white24),
          SizedBox(height: 12.h),
          Text(
            StringsManager.searchforamovie.tr(),
            style: TextStyle(color: Colors.white38, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
