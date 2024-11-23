import 'package:filmood/providers/FavoriteProvider.dart';
import 'package:filmood/providers/WatchLaterProvider.dart';
import 'package:filmood/screens/CategorieScreen.dart';
import 'package:filmood/screens/QuizScreen.dart';
import 'package:filmood/screens/SearchScreen.dart';
import 'package:filmood/firebase_options.dart';
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
  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => FavoriteProvider(FirebaseAuth.instance.currentUser?.uid ?? ''),
      ),
      ChangeNotifierProvider(
        create: (_) => WatchLaterProvider(FirebaseAuth.instance.currentUser?.uid ?? ''),
      ),
    ],
    child: MyApp(),
  ),
);

  
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => AuthenticationWrapper(), // Authentication logic
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
          '/home': (context) => MainAppScreen(),
        },
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
    HomeScreen(),
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
        selectedItemColor: const Color.fromARGB(255, 194, 113, 15),
        unselectedItemColor: const Color.fromARGB(255, 6, 6, 6),
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
          return MainAppScreen();
        } else {
          // User is not signed in, redirect to LoginScreen
          return LoginScreen();
        }
      },
    );
  }
}
