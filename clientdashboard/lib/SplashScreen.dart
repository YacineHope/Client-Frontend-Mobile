import 'package:clientdashboard/LoginPage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'IntroductionScreen.dart'; // Import the IntroductionScreen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final List<String> _images = [
    'assets/splashScreen/SplashPic1.jpg',
    'assets/splashScreen/SplashPic2.jpg',
    'assets/splashScreen/SplashPic3.jpg',
    'assets/splashScreen/SplashPic4.jpg',
    'assets/splashScreen/SplashPic5.jpg',
    'assets/splashScreen/SplashPic6.jpg',
    'assets/splashScreen/SplashPic7.jpg',
    'assets/splashScreen/SplashPic8.jpg',
    'assets/splashScreen/SplashPic9.jpg',
  ];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _images.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image slider
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: Image.asset(
              _images[_currentIndex],
              key: ValueKey<int>(_currentIndex),
              fit: BoxFit.cover,
              width: screenWidth,
              height: screenHeight,
            ),
          ),
          // Overlay content
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Logo and name
                Column(
                  children: [
                    // Logo
                    Container(
                      height: 110,
                      width: 110,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/splashScreen/Hotel logo.webp'), // Replace with your logo path
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Logo name
                    const Text(
                      "RoyalStay",
                      style: TextStyle(
                        fontFamily: 'Serif', // Use a luxurious Roman serif font
                        fontSize: 35, // Equivalent to 2.2rem
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A90E2), // Hex color #4A90E2
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.1),
                // Welcome text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: Text(
                    "Les meilleures offres d'hôtels pour vos vacances",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.06, // Responsive font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                // Get Started button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the IntroductionScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const IntroductionScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.2,
                      vertical: screenHeight * 0.02,
                    ),
                  ),
                  child: Text(
                    "Commencer",
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontSize: screenWidth * 0.045, // Responsive font size
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Already have an account? Log in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vous avez déjà un compte ?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.04, // Responsive font size
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to the login screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Se connecter",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.04, // Responsive font size
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
