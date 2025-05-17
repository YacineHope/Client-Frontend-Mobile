import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'HomePage.dart'; // Import the RoomPage
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Models.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _selectedCountry;
  String? _selectedProvince;
  bool _isPasswordVisible = false; // Ajouté pour l'œil

  final List<String> _countries = [
    'Algérie',
    'France',
    'Allemagne',
    'États-Unis'
  ];
  final List<String> _algerianProvinces = [
    'Adrar',
    'Chlef',
    'Laghouat',
    'Oum El Bouaghi',
    'Batna',
    'Béjaïa',
    'Biskra',
    'Béchar',
    'Blida',
    'Bouira',
    'Tamanrasset',
    'Tébessa',
    'Tlemcen',
    'Tiaret',
    'Tizi Ouzou',
    'Alger',
    'Djelfa',
    'Jijel',
    'Sétif',
    'Saïda',
    'Skikda',
    'Sidi Bel Abbès',
    'Annaba',
    'Guelma',
    'Constantine',
    'Médéa',
    'Mostaganem',
    'M’Sila',
    'Mascara',
    'Ouargla',
    'Oran',
    'El Bayadh',
    'Illizi',
    'Bordj Bou Arreridj',
    'Boumerdès',
    'El Tarf',
    'Tindouf',
    'Tissemsilt',
    'El Oued',
    'Khenchela',
    'Souk Ahras',
    'Tipaza',
    'Mila',
    'Aïn Defla',
    'Naâma',
    'Aïn Témouchent',
    'Ghardaïa',
    'Relizane',
    'Timimoun',
    'Bordj Badji Mokhtar',
    'Ouled Djellal',
    'Béni Abbès',
    'In Salah',
    'In Guezzam',
    'Touggourt',
    'Djanet',
    'El M’Ghair',
    'El Meniaa',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/Signup.jpg', // Replace with your image path
            fit: BoxFit.cover,
          ),
          // Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(
                          0.40), // Plus transparent pour le conteneur
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // First Name label and input
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Nom',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '*',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.85),
                              suffixIconConstraints: const BoxConstraints(
                                  minWidth: 0, minHeight: 0),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre nom';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          // Last Name label and input
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Prenom',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '*',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.85),
                              suffixIconConstraints: const BoxConstraints(
                                  minWidth: 0, minHeight: 0),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre prenom';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          // Country label and selector
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Le Pays',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 5),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.85),
                              prefixIcon:
                                  const Icon(Icons.public), // 🌍 Icône de pays
                            ),
                            value: _selectedCountry,
                            hint: const Text(
                                'Selectionner votre pays'), // <-- Placeholder ajouté ici
                            items: _countries
                                .map((country) => DropdownMenuItem(
                                      value: country,
                                      child: Text(country),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCountry = value;
                                _selectedProvince =
                                    null; // Reset province if country changes
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          // Province label and selector (only if Algeria is selected)
                          if (_selectedCountry == 'Algérie') ...[
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'La Wilaya',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 5),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.85),
                                prefixIcon: const Icon(Icons
                                    .location_on), // 📍 Icône localisation pour Wilaya
                              ),
                              value: _selectedProvince,
                              hint: const Text(
                                  'Selectionner votre Wilaya'), // <-- Placeholder ajouté ici
                              items: _algerianProvinces
                                  .map((province) => DropdownMenuItem(
                                        value: province,
                                        child: Text(province),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedProvince = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                          // Email label and input
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '*',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.85),
                              prefixIcon:
                                  const Icon(Icons.email), // ✉️ Icône email
                              suffixIconConstraints: const BoxConstraints(
                                  minWidth: 0, minHeight: 0),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre email';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Veuillez saisir une adresse e-mail valide';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          // Phone label and input
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Numero de telephone',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '*',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.85),
                              prefixIcon:
                                  const Icon(Icons.phone), // 📞 Icône téléphone
                              suffixIconConstraints: const BoxConstraints(
                                  minWidth: 0, minHeight: 0),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre numéro de téléphone';
                              }
                              if (!RegExp(r'^\+?[0-9]{7,15}$')
                                  .hasMatch(value)) {
                                return 'Veuillez entrer un numéro de téléphone valide';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          // Password label and input
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Mot de passe',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  '*',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: 'Contient au moins 6 caractères',
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.85),
                              prefixIcon: const Icon(Icons
                                  .vpn_key), // 🗝️ Icône clé pour mot de passe
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
                              suffixIconConstraints: const BoxConstraints(
                                  minWidth: 0, minHeight: 0),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre mot de passe';
                              }
                              if (value.length < 6) {
                                return 'Le mot de passe doit comporter au moins 6 caractères';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          // Sign Up button
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _signup();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'S\'inscrire',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Terms and conditions
                  const Text(
                    "En vous inscrivant, vous acceptez nos services et notre politique de confidentialité.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white, // Changed to white
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Already have an account? Login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Vous avez déjà un compte ?",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white, // Changed to white
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to LoginPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          " Se connecter",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            decoration: TextDecoration.none, // No underline
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signup() async {
    final url = Uri.parse('http://localhost:5000/api/auth/signup');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "nom": _firstNameController.text,
        "prenom": _lastNameController.text,
        "pays": _selectedCountry,
        "wilaya": _selectedCountry == 'Algérie' ? _selectedProvince : null,
        "email": _emailController.text,
        "numeroDeTelephone": _phoneController.text,
        "motDePasse": _passwordController.text,
      }),
    );
    if (response.statusCode == 201) {
      final user = User(
        nom: _firstNameController.text,
        prenom: _lastNameController.text,
        pays: _selectedCountry,
        wilaya: _selectedProvince,
        email: _emailController.text,
        numeroDeTelephone: _phoneController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            user: user,
            isNew: true,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Erreur: ${jsonDecode(response.body)['message']}')),
      );
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}

