import 'dart:async'; // Import for Timer
import 'ServicesPage.dart';
import 'package:flutter/material.dart';
import 'Sidebar.dart';
import 'Footer.dart';
import 'RoomPage.dart'; // Import RoomPage for navigation
// Import ProfilePage
import 'SplashScreen.dart'; // Import SplashScreen
import 'Models.dart';
import 'ProfilePage.dart'; // Import ProfilePage

class HomePage extends StatefulWidget {
  final User user;
  final bool isNew;
  const HomePage({super.key, required this.user, required this.isNew});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  String _newReview = ''; // Stocke le nouvel avis
  final TextEditingController _reviewController =
      TextEditingController(); // Contrôleur pour le champ d'entrée

  @override
  void initState() {
    super.initState();
    // Set up a timer to auto-scroll the images every 5 seconds
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageController.hasClients) {
        setState(() {
          _currentPage = (_currentPage + 1) % 3; // Loop through the images
        });
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Logo de l'hôtel
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/splashScreen/Hotel logo.webp', // Chemin vers le logo
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 10),
            // Nom de l'hôtel
            const Text(
              'RoyalStay',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.blue,
                fontSize: 20,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF6E4B2F),
        actions: [
          PopupMenuButton<String>(
            icon: const CircleAvatar(
              backgroundImage: AssetImage('assets/guest.png'),
              radius: 20,
            ),
            onSelected: (value) {
              if (value == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(user: widget.user),
                  ),
                );
              } else if (value == 'logout') {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SplashScreen(),
                  ),
                  (route) => false,
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'profile',
                child: Text('Voir le profil'),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Text('Déconnecter'),
              ),
            ],
          ),
        ],
      ),
      drawer: const Drawer(
        child: Sidebar(), // Use the Sidebar widget here
      ),
      backgroundColor: const Color.fromARGB(255, 232, 196, 167),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2. Description de l'Hôtel
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 235, 171), // Fond blanc
                borderRadius: BorderRadius.circular(10), // Coins arrondis
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage(
                      'assets/splashScreen/SplashPic6.jpg'), // Image d'arrière-plan
                  fit: BoxFit.cover, // L'image s'adapte au conteneur
                  opacity: 0.3, // Transparence de l'image
                ),
              ),
              child: const Text(
                'Bienvenue à RoyalStay Hotel, un hôtel 5 étoiles offrant des services de luxe, des chambres confortables et une vue imprenable sur la mer.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 255, 255, 255), // Texte en noir
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 0),
              child: Text(
                widget.isNew
                    ? "Bonjour ${widget.user.nom} ${widget.user.prenom} !"
                    : "Bon retour ${widget.user.nom} ${widget.user.prenom} !",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ),

            // 3. Carrousel d'Images

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Decouvrez Nos Chambres',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: screenHeight * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      final images = [
                        'assets/rooms/room1001.png',
                        'assets/rooms/room1002.png',
                        'assets/rooms/room1003.png',
                      ];
                      return ClipRRect(
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  Container(
                    alignment: Alignment.center,
                    color: Colors.black.withOpacity(0.5),
                    child: const Text(
                      'Profitez à réserver des chambres de votre choix',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to availability page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RoomPage(user: widget.user),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6E4B2F),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Voir la disponibilité',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 4. Services Disponibles
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Decouvrez Nos Services',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: screenHeight * 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      final images = [
                        'assets/services/restauration.webp',
                        'assets/services/gym2.webp',
                        'assets/services/spa.webp',
                      ];
                      return ClipRRect(
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  Container(
                    alignment: Alignment.center,
                    color: Colors.black.withOpacity(0.5),
                    child: const Text(
                      'N\'hesitez pas à profiter de nos services',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to availability page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ServicesPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6E4B2F),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Acceder aux services',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 5. Avis des Clients
            // 5. Avis des Clients
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Avis des Clients',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    // Liste des avis existants
                    Column(
                      children: [
                        const ListTile(
                          leading: Icon(Icons.star, color: Colors.orange),
                          title: Text('John Doe'),
                          subtitle: Text(
                              'Un séjour incroyable avec un service exceptionnel !'),
                        ),
                        const ListTile(
                          leading: Icon(Icons.star, color: Colors.orange),
                          title: Text('Jane Smith'),
                          subtitle: Text(
                              'Les chambres sont magnifiques et très confortables.'),
                        ),
                        // Nouvel avis ajouté dynamiquement
                        if (_newReview.isNotEmpty)
                          ListTile(
                            leading:
                                const Icon(Icons.star, color: Colors.orange),
                            title: const Text('Vous'),
                            subtitle: Text(_newReview),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Champ d'entrée pour ajouter un avis
                    TextField(
                      controller: _reviewController,
                      decoration: InputDecoration(
                        hintText: 'Écrivez votre avis ici...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 10),
                    // Bouton pour soumettre l'avis
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _newReview = _reviewController.text;
                            _reviewController
                                .clear(); // Efface le champ après soumission
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6E4B2F),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Ajouter un avis',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 6. Promotions et Offres Spéciales
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Promotions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Réservez maintenant et bénéficiez de 20% de réduction sur votre séjour !',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
