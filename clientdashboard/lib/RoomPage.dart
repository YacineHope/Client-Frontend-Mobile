import 'package:flutter/material.dart';
import 'Sidebar.dart'; // Import Sidebar
import 'RoomDetailsPage.dart'; // Import RoomDetailsPage
import 'Models.dart'; // Import Room model

class RoomPage extends StatelessWidget {
  final User user; // User object to pass to Sidebar
  const RoomPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the title
          children: [
            Icon(Icons.hotel, color: Colors.white), // Add an icon
            SizedBox(width: 8), // Add spacing between the icon and text
            Text(
              'Les Chambres',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF6E4B2F), // AppBar color
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            // Sidebar icon
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open the sidebar
            },
          ),
        ),
        centerTitle: true, // Ensure the title is centered
      ),
      drawer: const Drawer(
        child: Sidebar(), // Add the Sidebar widget
      ),
      backgroundColor: const Color.fromARGB(255, 232, 196, 167),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: rooms.length, // Use the list of rooms from Models.dart
        itemBuilder: (context, index) {
          final room = rooms[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  // Room image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      room.images[0], // Display the first image of the room
                      width: screenWidth * 0.4,
                      height: screenWidth * 0.4,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Room details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Room name
                        Text(
                          room.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Room type
                        Text(
                          room.type,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        // Room price
                        Text(
                          '${room.price} DZD / nuit', // Display the price
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // Ratings
                        Row(
                          children: List.generate(
                            5,
                            (starIndex) => Icon(
                              Icons.star,
                              color: starIndex < room.rating.floor()
                                  ? Colors.amber
                                  : Colors.grey,
                              size: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Voir les details button
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to RoomDetailsPage
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RoomDetailsPage(
                                    roomDetails: room,
                                    currentUser: user // Passe l'utilisateur courant ici
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF6E4B2F), // Base color
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shadowColor:
                                  const Color(0xFF8C6239), // Mixed shadow color
                            ),
                            child: const Text(
                              'Voir les details',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
