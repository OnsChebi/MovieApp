import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => BarreRapide(),
        '/home': (context) => HomePage(),
        '/categorie': (context) => CategoriePage(),
        '/recherche': (context) => RecherchePage(),
        '/quiz': (context) => QuizzPage(),
      },
    );
  }
}

class BarreRapide extends StatefulWidget {
  @override
  _BarreRapideState createState() => _BarreRapideState();
}

class _BarreRapideState extends State<BarreRapide> {
  int _selectedIndex = 0; // Index de l'onglet sélectionné

  // Méthode pour naviguer vers une nouvelle page
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigation en fonction de l'index
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/categorie');
        break;
      case 2:
        Navigator.pushNamed(context, '/recherche');
        break;
      case 3:
        Navigator.pushNamed(context, '/quiz');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Bienvenue dans l\'application !',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Catégorie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
        ],
        selectedItemColor: Colors.blue, // Couleur de l'onglet sélectionné
        unselectedItemColor: Colors.grey, // Couleur des onglets non sélectionnés
      ),
    );
  }
}

// Pages associées aux onglets
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      body: Center(
        child: Text(
          'Bienvenue à la page Accueil',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class CategoriePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catégorie'),
      ),
      body: Center(
        child: Text(
          'Bienvenue à la page Catégorie',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class RecherchePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recherche'),
      ),
      body: Center(
        child: Text(
          'Bienvenue à la page Recherche',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class QuizzPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Center(
        child: Text(
          'Bienvenue à la page Quiz',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
