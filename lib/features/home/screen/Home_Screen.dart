

import 'package:flutter/material.dart';
import 'package:movies_app/core/resources/ColorsManager.dart';
import 'package:movies_app/features/home/Tabs/Profiel/Profiel_tab.dart';

import '../Tabs/Browse/Browse_tab.dart';
import '../Tabs/Search/Search_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  PageController controller=PageController(
    viewportFraction: 0.5,
  );
  int selectedIndex=0;

  List<Widget>tabs=[
    HomeScreen(),
    ProfielTab(),
    SearchTab(),
    BrowseTab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
      NavigationBar(
          onDestinationSelected: (value) {
            setState(() {
            selectedIndex = value;
            });
          } ,
          selectedIndex: selectedIndex,
          backgroundColor: ColorsManager.PrimaryColor,
          indicatorColor: ColorsManager.SecondaryColor.withValues(
              alpha: 0.6
          ),

          destinations: [
            NavigationDestination(label: "",
              icon:Icon(Icons.home_rounded)
             ),
            NavigationDestination(
              icon:Icon(Icons.search_outlined),
              label: "",
            ),

            NavigationDestination(
              icon:Icon(Icons.explore_sharp),
              label: "",
            ),
            NavigationDestination(
              icon:Icon(Icons.person),
              label: "",
            ),


          ]),
      body:tabs[selectedIndex],
    )

    ;
  }
}

