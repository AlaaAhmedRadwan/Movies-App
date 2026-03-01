import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';
import 'package:movies_app/features/home/Tabs/Home/HomeTab.dart';
import 'package:movies_app/features/home/Tabs/Profiel/Profiel_tab.dart';
import '../Tabs/Browse/Browse_tab.dart';
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
      ProfielTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[selectedIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        backgroundColor: ColorsManager.PrimaryColor,
        indicatorColor:
        ColorsManager.SecondaryColor.withValues(alpha: 0.6),
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
    );
  }
}