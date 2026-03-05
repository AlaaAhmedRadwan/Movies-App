import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  static const Color backgroundColor = Color(0xFF121312);
  static const Color searchBarColor = Color(0xFF282A28);
  static const Color hintColor = Color(0xFFFFFFFF);
  static const Color bottomNavColor = Color(0xFF282A28);
  static const Color activeColor = Color(0xFFFFBB3B);
  static const Color inactiveColor = Color(0xFF57AA53);
  int currentIndex = 1;
  final TextEditingController searchController = TextEditingController();



  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        child: Column(
          children: [


            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: searchBarColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: hintColor),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        cursorColor: activeColor,
                        style: TextStyle(color: hintColor),
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(color: hintColor),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),


            Expanded(
              child: Center(
                child: SizedBox(
                  width: 140,
                  height: 140,


                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFBB3B),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/Empty.png',
                        width: 26,
                        height: 26,
                        color: Color(0xFF121312),
                      ),
                    ),
                  ),


                  ),
                ),
              ),
            );

        ),
      );


          bottomNavigationBar: Container(
          height: 70,
          decoration: BoxDecoration(
          color: bottomNavColor,
          borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
          ),
          ),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          navItem(icon: Icons.home, index: 0),
          navItem(icon: Icons.search, index: 1),
          navItem(icon: Icons.confirmation_number, index: 2),
          navItem(icon: Icons.person, index: 3),
    ],
    ),
    );

  }

  Widget navItem({required IconData icon, required int index}) {
    final bool isSelected = currentIndex == index;

    return IconButton(
      onPressed: () {
        setState(() {
          currentIndex = index;
        });
      },
      icon: Icon(
        icon,
        size: 28,
        color: isSelected ? activeColor : inactiveColor,
      ),
    );
  }
}
