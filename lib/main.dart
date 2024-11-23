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
