import 'package:flutter/material.dart';
import 'RoomPage.dart';
import 'HomePage.dart';
import 'ProfilePage.dart';
import 'ServicesPage.dart'; // Import ServicesPage
import 'Models.dart'; // Import Models to access User data
import 'SplashScreen.dart'; // Import SplashScreen for logout

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Example user data (replace with actual user data from your app)
    final User currentUser = User(
      nom: 'Doe',
      prenom: 'John',
      pays: 'Algeria',
      wilaya: 'Alger',
      email: 'john.doe@example.com',
      numeroDeTelephone: '+213123456789',
      motDePasse: 'password123',
    );

    return Container(
      width: screenWidth < 600 ? screenWidth * 0.7 : 270, // Responsive width
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
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Client Dashboard',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildMenuItem(
              context,
              icon: Icons.person,
              title: 'Voir le profile',
              onTap: () {
                // Navigate to Profile Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(user: currentUser),
                  ),
                );
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.home,
              title: 'Accueil',
              onTap: () {
                // Navigate to Home Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.hotel,
              title: 'Les Chambres',
              onTap: () {
                // Navigate to RoomPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RoomPage(),
                  ),
                );
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.room_service,
              title: 'Services',
              onTap: () {
                // Navigate to ServicesPage
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
              icon: Icons.history,
              title: 'Historique des séjours',
              onTap: () {
                // Navigate to History Page
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.bar_chart,
              title: 'Statistiques',
              onTap: () {
                // Navigate to Statistics Page
              },
            ),
            _buildMenuItem(
              context,
              icon: Icons.logout,
              title: 'Déconnexion',
              onTap: () {
                // Navigate to SplashScreen
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                  (route) => false, // Remove all previous routes
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
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      onTap: onTap,
    );
  }
}
