import 'package:filmood/screens/DrawerScreen.dart';
import 'package:filmood/screens/movie_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:filmood/providers/movie_provider.dart';
import 'package:filmood/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            DrawerScreen(),
            HomeScreen(),
          ],
        ),
      ),
      ),
    );
  }
}
