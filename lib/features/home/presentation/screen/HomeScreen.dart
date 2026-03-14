import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/di/get_it.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';
import 'package:movies_app/features/home/presentation/Tabs/Home/HomeTab.dart';
import 'package:movies_app/features/home/presentation/Tabs/Profile/Profile_tab.dart';
import 'package:movies_app/features/home/presentation/cubit/movies_cubit.dart';
import 'package:movies_app/features/home/presentation/cubit/search_cubit.dart';

import '../Tabs/Browse/screen/Browse_tab.dart';
import '../Tabs/Search/SearchTab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  late final List<Widget> tabs;

  @override
  void initState() {
    super.initState();
    tabs = [
       HomeTap(),
      SearchTab(),
      BrowseTab(),
      ProfileTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<MoviesCubit>()..getMovies()),
        BlocProvider(create: (_) => sl<SearchCubit>()),
      ],
      child: Scaffold(
        backgroundColor: Colors.black,
        body: tabs[selectedIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          backgroundColor: ColorsManager.PrimaryColor,
          indicatorColor: ColorsManager.SecondaryColor.withValues(alpha: 0.6),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_rounded),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.search_outlined),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.explore_sharp),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}