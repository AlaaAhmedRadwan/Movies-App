import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<String> movies = [

  ];


  int selectedIndex = 0;


  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: AssetImage(movies[selectedIndex]),
          alignment: Alignment.topCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [

            Image.asset(

              width: screenWidth * 0.1,
              fit: BoxFit.fitWidth,
            ),

            const SizedBox(height: 20),

            // PageView
            SizedBox(
              height: 350,
              child: PageView.builder(
                controller: _pageController,
                itemCount: movies.length,
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return MovieCard(movie: movies[index]);
                },
              ),
            ),

            const SizedBox(height: 20),


            ElevatedButton(
              onPressed: () {},
              child: const Text("Watch Now"),
            ),
          ],
        ),
      ),
    );
  }
}


class MovieCard extends StatelessWidget {
  final String movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          movie,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}