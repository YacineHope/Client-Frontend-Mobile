import 'package:flutter/material.dart';
import 'Models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EditProfilePage extends StatefulWidget {
  final User user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nomController;
  late TextEditingController _prenomController;
  late TextEditingController _emailController;
  late TextEditingController _numeroController;
  late TextEditingController _paysController;
  late TextEditingController _wilayaController;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.user.nom);
    _prenomController = TextEditingController(text: widget.user.prenom);
    _emailController = TextEditingController(text: widget.user.email);
    _numeroController =
        TextEditingController(text: widget.user.numeroDeTelephone);
    _paysController = TextEditingController(text: widget.user.pays ?? '');
    _wilayaController = TextEditingController(text: widget.user.wilaya ?? '');
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _numeroController.dispose();
    _paysController.dispose();
    _wilayaController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    final url = Uri.parse(
        'http://localhost:5000/api/auth/update'); // Crée cette route côté Node.js
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": _emailController.text, // Utilisé comme identifiant
        "nom": _nomController.text,
        "prenom": _prenomController.text,
        "pays": _paysController.text,
        "wilaya": _wilayaController.text,
        "numeroDeTelephone": _numeroController.text,
      }),
    );
    if (response.statusCode == 200) {
      Navigator.pop(context, true); // Retourne à la page précédente
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Erreur: ${jsonDecode(response.body)['message']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8C6239),
        title: Row(
          children: const [
            Icon(Icons.edit, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Modifier le profil',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 232, 196, 167),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              TextField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: 'Nom'),
              ),
              TextField(
                controller: _prenomController,
                decoration: const InputDecoration(labelText: 'Prénom'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                enabled: false, // Email non modifiable
              ),
              TextField(
                controller: _numeroController,
                decoration: const InputDecoration(labelText: 'Téléphone'),
              ),
              TextField(
                controller: _paysController,
                decoration: const InputDecoration(labelText: 'Pays'),
              ),
              TextField(
                controller: _wilayaController,
                decoration: const InputDecoration(labelText: 'Wilaya'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8C6239),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Enregistrer',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
