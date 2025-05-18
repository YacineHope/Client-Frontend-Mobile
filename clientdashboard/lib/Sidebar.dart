import 'package:flutter/material.dart';
import 'RoomPage.dart';
import 'HomePage.dart';
import 'ServicesPage.dart';
import 'Models.dart';
import 'SplashScreen.dart';
import 'ProfilePage.dart';

class Sidebar extends StatelessWidget {
  final User user;

  const Sidebar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth < 600 ? screenWidth * 0.7 : 270,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF6E4B2F), Color(0xFF8C6239), Color(0xFF6E4B2F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(10, 0),
            blurRadius: 30,
          ),
          BoxShadow(
            color: Colors.white10,
            offset: Offset(-1, 0),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
        border: Border(
          right: BorderSide(color: Colors.white10, width: 1),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // New container for logo and hotel name
            Container(
              color: const Color.fromARGB(255, 232, 196, 167),
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Image.asset(
                    'assets/splashScreen/Hotel logo.webp',
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Royal Stay',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildMenuItem(
              context,
              icon: Icons.person,
              title: 'Voir le profile',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(user: user),
                  ),
                );
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.home,
              title: 'Accueil',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(user: user, isNew: false),
                  ),
                );
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.hotel,
              title: 'Les Chambres',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoomPage(user: user),
                  ),
                );
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.room_service,
              title: 'Services',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ServicesPage(),
                  ),
                );
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.logout,
              title: 'Déconnexion',
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: onTap,
        hoverColor: Colors.transparent,
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        onHover: (isHovered) {
          // The hover effect is handled by the AnimatedContainer
        },
        // Adding a custom hover animation with background color change
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.white.withOpacity(0.2);
            }
            return Colors.transparent;
          },
        ),
      ),
    );
  }
}
