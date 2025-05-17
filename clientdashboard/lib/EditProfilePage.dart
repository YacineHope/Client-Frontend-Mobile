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
    _numeroController = TextEditingController(text: widget.user.numeroDeTelephone);
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
    final url = Uri.parse('http://localhost:5000/api/auth/update'); // Crée cette route côté Node.js
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
        SnackBar(content: Text('Erreur: ${jsonDecode(response.body)['message']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modifier le profil')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
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
              child: const Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}