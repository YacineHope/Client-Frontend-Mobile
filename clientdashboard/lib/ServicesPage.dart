import 'package:clientdashboard/GymServicesPage.dart';
import 'package:flutter/material.dart';
// Import Sidebar
import 'RestaurationServicesPage.dart';
import 'SpaServices.dart'; // Import the RestaurationServicesPage
// Import the GymServicesPage

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 196, 167),
      appBar: AppBar(
          centerTitle: true, // Center the title
          title: const Row(
            mainAxisSize:
                MainAxisSize.min, // Ensure the Row takes minimal space
            children: [
              Icon(Icons.room_service,
                  color: Colors.white), // Icon near the title
              SizedBox(width: 8), // Add some spacing between the icon and title
              Text(
                'Services',
                style: TextStyle(color: Colors.white), // Title in white
              ),
            ],
          ),
          backgroundColor: const Color(0xFF8C6239)),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          // First Container: Restauration
          _buildServiceContainer(
            imagePath:
                'assets/services/restauration.webp', // Replace with your image path
            heading: 'Restauration',
            description: 'Commander des repas en chambre',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RestaurationServicesPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          // Second Container: Gym
          _buildServiceContainer(
            imagePath:
                'assets/services/gym2.webp', // Replace with your image path
            heading: 'Gym',
            description: 'Accéder à la salle de sport et aux équipements',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GymServicesPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          // Third Container: Spa
          _buildServiceContainer(
            imagePath:
                'assets/services/spa.webp', // Replace with your image path
            heading: 'Spa',
            description: 'Réserver des séances de massage ou de bien-être',
            onTap: () {
              // Add navigation to the Spa services page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SpaServicesPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Helper method to build a service container
  Widget _buildServiceContainer({
    required String imagePath,
    required String heading,
    required String description,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background image
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            // Overlay with heading and description
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.3),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      heading,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
