import 'package:flutter/material.dart';
import 'package:filmood/screens/FavoriteScreen.dart';
import 'package:filmood/screens/SearchScreen.dart';
import 'package:filmood/screens/WatchLaterScreen.dart';
import 'package:filmood/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:filmood/providers/movie_provider.dart';
import 'package:filmood/models/movies_model.dart';
import 'package:filmood/screens/movie_grid_screen.dart';
import 'package:filmood/widgets/horizontal_movie_list.dart';
import 'package:filmood/widgets/movie_carousel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieProvider>(context, listen: false).fetchAllMovies();
    });
  }

  void toggleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      xOffset = isDrawerOpen ? 250 : 0;
      yOffset = isDrawerOpen ? 100 : 0;
      scaleFactor = isDrawerOpen ? 0.85 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Stack(
      children: [
        // Drawer Screen
        Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 40, bottom: 70),
            child: ListView(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 85,
                      backgroundColor: Colors.black,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.cover,
                          width: 350,
                          height: 350,
                          //color: const Color.fromARGB(255, 250, 121, 0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    /* const Text(
                      'filmood',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ), */
                  ],
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading:
                      const Icon(Icons.favorite_border, color: Colors.white),
                  title: const Text(
                    'Favorites',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoriteScreen(userId: ''),
                      ),
                    );
                  },
                ),
                Divider(color: Colors.white.withOpacity(0.5)),
                ListTile(
                  leading: const Icon(Icons.watch_later_outlined,
                      color: Colors.white),
                  title: const Text(
                    'Watch Later',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WatchLaterScreen(userId: ''),
                      ),
                    );
                  },
                ),
                Divider(color: Colors.white.withOpacity(0.5)),
                ListTile(
                  leading:
                      Icon(Icons.logout, color: Colors.white.withOpacity(0.8)),
                  title: Text(
                    'Log Out',
                    style: TextStyle(color: Colors.white.withOpacity(0.8)),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        // Main Content
        AnimatedContainer(
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(scaleFactor),
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: isDrawerOpen
                ? BorderRadius.circular(20)
                : BorderRadius.circular(0),
          ),
          child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            appBar: AppBar(
              title: Image.asset(
                'assets/logo.png',
                height: 200,
              ),
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 250, 121, 0),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: MovieSearchDelegate(),
                    );
                  },
                ),
              ],
              leading: GestureDetector(
                onTap: toggleDrawer,
                child: Icon(
                  isDrawerOpen ? Icons.arrow_back_ios : Icons.menu,
                  color: Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (movieProvider.trendingMovies.isNotEmpty)
                    MovieCarousel(
                      movies: movieProvider.trendingMovies,
                      title: 'Trending Now',
                    ),
                  if (movieProvider.upcomingMovies.isNotEmpty)
                    _buildSection(
                      context,
                      title: 'Upcoming Movies',
                      movies: movieProvider.upcomingMovies,
                    ),
                  if (movieProvider.popularMovies.isNotEmpty)
                    _buildSection(
                      context,
                      title: 'Popular Movies',
                      movies: movieProvider.popularMovies,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required List<MovieModel> movies}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieGridScreen(
                    title: title,
                    movies: movies,
                  ),
                ),
              );
            },
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 250, 121, 0),
              ),
            ),
          ),
        ),
        HorizontalMovieList(movies: movies),
      ],
    );
  }
}
