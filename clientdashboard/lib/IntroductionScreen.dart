import 'dart:async'; // Import for Timer
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'LoginPage.dart';
import 'SignUpPage.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _pageController = PageController();
  final List<String> _backgroundImages = [
    'assets/introductionScreen/Plan.jpg',
    'assets/introductionScreen/Deals.jpg',
    'assets/introductionScreen/Travelling.jpg',
  ];

  @override
  void initState() {
    super.initState();
    // Automatically scroll the PageView
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        if (_pageController.page != _backgroundImages.length - 1) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
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
      body: Center(
        child: Stack(
          children: [
            // PageView with background images
            PageView.builder(
              controller: _pageController,
              itemCount: _backgroundImages.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    // Background image
                    Container(
                      width: screenWidth,
                      height: screenHeight,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(_backgroundImages[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Page content
                    _buildPage(
                      heading: index == 0
                          ? "Planifiez vos voyages"
                          : index == 1
                              ? "Trouvez les meilleures offres"
                              : "Meilleur voyage à l'heure actuelle",
                      description: index == 0
                          ? "Réservez l'un de vos hôtels uniques pour échapper à l'ordinaire."
                          : index == 1
                              ? "Trouvez des offres pour toutes les saisons, des maisons de campagne confortables aux appartements en ville."
                              : "Trouvez des offres pour toutes les saisons, des maisons de campagne confortables aux appartements en ville.",
                    ),
                  ],
                );
              },
            ),
            // Smooth Page Indicator
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 200.0),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: _backgroundImages.length,
                  effect: const WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.green,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
              ),
            ),
            // Fixed Buttons

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 32.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Se connecter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: () {
                        // Navigate to the SignUpPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 220, 213, 185),
                        side: const BorderSide(
                            color: Color.fromARGB(
                                255, 133, 132, 132)), // Black border
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal:
                              32.0, // Adjust horizontal padding for button size
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Créer un compte',
                        style: TextStyle(
                          color: Color.fromARGB(255, 79, 77, 77), // Black text
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  Widget _buildPage({required String heading, required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            heading,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
