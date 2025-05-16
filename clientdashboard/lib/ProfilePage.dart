import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'Models.dart'; // Import Models.dart to access user information
import 'Sidebar.dart';

class ProfilePage extends StatefulWidget {
  final User? user; // Peut être null si pas de données passées

  const ProfilePage({super.key, this.user});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage; // To store the profile picture
  bool _isPasswordVisible = false; // To toggle password visibility

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6E4B2F),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title:const Row(
          mainAxisSize: MainAxisSize.min,
          children:  [
            Icon(Icons.person, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Profile',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      drawer: const Drawer(
        child: Sidebar(),
      ),
      backgroundColor: const Color.fromARGB(255, 232, 196, 167),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!) as ImageProvider
                        : const AssetImage(
                            'assets/guest.png'), // Default guest image
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: _pickImage,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Profile Info in a white container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Name
                  Center(
                    child: Text(
                      widget.user != null
                          ? "${widget.user!.nom} ${widget.user!.prenom}"
                          : "Invité",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (widget.user != null) ...[
                    _buildDetailRow("Pays", widget.user!.pays ?? "Non défini"),
                    _buildDetailRow(
                        "Wilaya", widget.user!.wilaya ?? "Non défini"),
                    _buildDetailRow("Email", widget.user!.email),
                    _buildDetailRow(
                        "Numéro de téléphone", widget.user!.numeroDeTelephone),
                    _buildPasswordRow("Mot de passe", widget.user!.motDePasse),
                  ],
                  const SizedBox(height: 30),
                  // Modify Profile Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to a page to modify the profile
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6E4B2F),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Modifier Le Profile',
                        style: TextStyle(color: Colors.white, fontSize: 16),
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
  }

  // Widget to build a row for user details
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build a row for the password
  Widget _buildPasswordRow(String label, String password) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: TextFormField(
              initialValue: password,
              obscureText: !_isPasswordVisible,
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
