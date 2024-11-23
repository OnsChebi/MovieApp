import 'package:filmood/screens/CategorieScreen.dart';
import 'package:filmood/screens/DrawerScreen.dart';
import 'package:filmood/screens/movie_details.dart';
import 'package:filmood/firebase_options.dart';
import 'package:filmood/screens/DrawerScreen.dart';
import 'package:filmood/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:filmood/providers/movie_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:filmood/screens/login_screen.dart';
import 'package:filmood/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainAppScreen(),
      ),
    );
  }
}

class MainAppScreen extends StatefulWidget {
  @override
  _MainAppScreenState createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0;

  // List of screens for navigation
  final List<Widget> _screens = [
    HomeStack(),
    CategorieScreen(),
    SearchScreen(),
    QuizScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

// Stack for HomeScreen with Drawer
class HomeStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DrawerScreen(),
        HomeScreen(),
      ],
    );
  }
}

// Search screen using SearchDelegate
class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: MovieSearchDelegate());
            },
          ),
        ],
      ),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          if (movieProvider.allMovies.isEmpty) {
            return const Center(
              child: Text('No movies available'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: movieProvider.allMovies.length,
            itemBuilder: (context, index) {
              final movie = movieProvider.allMovies[index];
              return ListTile(
                leading: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  width: 50,
                  height: 75,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  movie.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoviesDetailScreen(movie: movie),
                      ));
                },
              );
            },
          );
        },
      ),
    );
  }
}

class MovieSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    final searchResults = movieProvider.allMovies
        .where(
            (movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.movie_filter, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 20),
            Text(
              'No results found for "$query"',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final movie = searchResults[index];
        return ListTile(
          leading: Image.network(
            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            width: 50,
            height: 75,
            fit: BoxFit.cover,
          ),
          title: Text(
            movie.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          onTap: () {
            close(context, movie);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);

    // Show most popular movies if no query is entered
    if (query.isEmpty) {
      final popularMovies = movieProvider.topRatedMovies;

      return ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: popularMovies.length,
        itemBuilder: (context, index) {
          final movie = popularMovies[index];
          return ListTile(
            leading: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              width: 50,
              height: 75,
              fit: BoxFit.cover,
            ),
            title: Text(
              movie.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              close(context, movie);
            },
          );
        },
      );
    }

    // Show suggestions based on the query
    final suggestions = movieProvider.allMovies
        .where(
            (movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (suggestions.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: suggestions.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final movie = suggestions[index];
        return ListTile(
          leading: Image.network(
            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            width: 50,
            height: 75,
            fit: BoxFit.cover,
          ),
          title: Text(
            movie.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            'Release Date: ${movie.releaseDate}',
            style: const TextStyle(color: Colors.grey),
          ),
          onTap: () {
            close(context, movie); // Close search with the selected movie
          },
        );
      },
    );
  }
}

// Placeholder for Quiz screen
class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Quiz Screen',
        style: TextStyle(fontSize: 24),
        initialRoute: '/', // Define the initial route
        routes: {
          '/': (context) => AuthenticationWrapper(), // Home route
          '/login': (context) => LoginScreen(), // Login route
          '/home': (context) => HomeScreen(), // Home screen route
          '/signup': (context) => SignupScreen(), // Drawer screen route
        },
      ),
    );
  }
}

/// This widget decides whether to show HomeScreen or LoginScreen
class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Check if the user is authenticated
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // User is signed in
          return Scaffold(
            body: Stack(
              children: [
                DrawerScreen(), // Optional: Can be a drawer screen for navigation
                HomeScreen(),   // Display HomeScreen if authenticated
              ],
            ),
          );
        } else {
          // User is not signed in, redirect to LoginScreen
          return LoginScreen(); // Redirect to LoginScreen
        }
      },
    );
  }
}
