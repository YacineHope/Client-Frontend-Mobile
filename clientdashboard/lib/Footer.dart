import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For social media icons
import 'package:url_launcher/url_launcher.dart'; // For opening URLs

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year; // Get the current year dynamically

    return Container(
      color: const Color(0xFF333333), // Background color
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contact Information
          const Text(
            '🏨 RoyalStay\n\n📍 Adresse : 123 Rue de l\'Hôtel, Alger, Algérie\n\n📞 Téléphone : +213 530 204 189\n\n✉️ E-mail : contactinfo@royalstay.com',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 20),

          // Follow Us Section
          const Text(
            'Suivez-nous :',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.instagram,
                    color: Colors.white),
                onPressed: () => _launchURL('https://www.instagram.com'),
              ),
              IconButton(
                icon:
                    const FaIcon(FontAwesomeIcons.twitter, color: Colors.white),
                onPressed: () => _launchURL('https://www.twitter.com'),
              ),
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.facebook,
                    color: Colors.white),
                onPressed: () => _launchURL('https://www.facebook.com'),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Location Section
          const Text(
            'Notre emplacement :',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const Image(
                image: NetworkImage(
                  'https://maps.googleapis.com/maps/api/staticmap?center=Alger,Algerie&zoom=15&size=600x300&maptype=roadmap&markers=color:red%7Clabel:H%7C36.737232,3.086472&key=YOUR_GOOGLE_MAPS_API_KEY',
                ), // Replace with your Google Maps API key
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Awards and Certifications
          const Text(
            'Récompenses et certifications :',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              Icon(Icons.star, color: Colors.yellow, size: 30),
              SizedBox(width: 10),
              Text(
                'Meilleur Hôtel 2025',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              Icon(Icons.eco, color: Colors.green, size: 30),
              SizedBox(width: 10),
              Text(
                'Certification Écologique',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Copyright Section
          Center(
            child: Text(
              '©$currentYear RoyalStay Hôtel. Tous droits réservés.',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to open URLs
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
