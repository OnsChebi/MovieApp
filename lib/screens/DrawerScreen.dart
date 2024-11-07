import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 116, 16, 184),
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 40, bottom: 70),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 30, // Adjust radius
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'filmood',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // List of items
            const ListTile(
              leading: Icon(Icons.chat_bubble_outline, color: Colors.white),
              title: Text(
                'Messages',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Divider(color: Colors.white.withOpacity(0.5)), // Add divider for separation
            const ListTile(
              leading: Icon(Icons.favorite_border, color: Colors.white),
              title: Text(
                'Favorites',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Divider(color: Colors.white.withOpacity(0.5)),
            // Log out section
            ListTile(
              leading: Icon(Icons.cancel, color: Colors.white.withOpacity(0.5)),
              title: Text(
                'Log out',
                style: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
              onTap: () {
                // Implement logout functionality here
              },
            ),
          ],
        ),
      ),
    );
  }
}
