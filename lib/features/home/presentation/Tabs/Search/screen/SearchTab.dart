import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/resources/AssetsManager.dart';
import 'package:movies_app/core/resources/StringsManager.dart';
import 'package:movies_app/features/auth/presentation/widgets/CustomAuthTextField.dart';

import '../../../../../../core/resources/ColorsManager.dart';
import '../../../cubit/movies_cubit.dart';
import '../../../cubit/movies_state.dart';
import '../widget/MovieGrid.dart';

class SearchTab extends StatefulWidget {

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  Timer? debounce;
  @override
  void dispose() {
   searchController.dispose();
   debounce?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.PrimaryColor,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              Container(
                padding: EdgeInsets.symmetric(
                horizontal: 16
                ),
                height: 55.72.h,
                child: CustomAuthTextField(
                  hintText: StringsManager.search.tr(),
                  prefixIcon: Icons.search_outlined,
                  controller: searchController,
                  onChanged: (value) {

                    if (debounce?.isActive ?? false) debounce!.cancel();
                    debounce = Timer(const Duration(milliseconds: 500), () {
                      if(value.isNotEmpty){
                        context.read<MoviesCubit>().searchMovies(value);
                      }
                    });
                    setState(() {});
                  },
                ),
              ),

              SizedBox(height: 20.h),

              Expanded(
                child: searchController.text.isEmpty
                    ? Center(
                  child: Image.asset(Assetsmanager.searchempty),
                )
                    : BlocBuilder<MoviesCubit, MoviesState>(
                  builder: (context, state) {

                    if(state is MoviesLoading){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if(state is MoviesLoaded){
                      return MovieGrid(
                        movies: state.movies,
                      );
                    }

                    return Center(
                      child: Image.asset(Assetsmanager.searchempty),
                    );

                  },
                ),
              ),

            ],
          )
                ),
      ));
  }
}