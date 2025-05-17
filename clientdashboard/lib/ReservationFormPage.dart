import 'package:flutter/material.dart';
import 'Models.dart'; // Ajoutez ceci en haut si ce n'est pas déjà fait
import 'dart:convert';
import 'package:http/http.dart' as http;

class ReservationFormPage extends StatefulWidget {
  final Room?
      selectedRoom; // Ajoutez ce paramètre pour recevoir la chambre sélectionnée
  final User? currentUser;
  // Ajoutez ce paramètre pour recevoir la chambre sélectionnée

  const ReservationFormPage({super.key, this.selectedRoom, this.currentUser});

  @override
  _ReservationFormPageState createState() => _ReservationFormPageState();
}

class _ReservationFormPageState extends State<ReservationFormPage> {
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  // Controllers for inputs
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _specialRequestController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _transportDateController =
      TextEditingController();
  final TextEditingController _transportTimeController =
      TextEditingController();

  // State variables
  String? _selectedCountry;
  String? _selectedProvince;
  String? _selectedIdType;
  bool _showIdInput = false;
  String? _selectedTransportMode;
  String? _selectedPaymentMethod;
  bool _saveCardForFuture = false;

  // Special requests
  bool _litBebe = false;
  bool _etageEleve = false;
  final bool _chambreAntiAllergique = false;
  bool _autres = false;

  @override
  void initState() {
    super.initState();
    if (widget.currentUser != null) {
      _nameController.text = widget.currentUser!.nom;
      _surnameController.text = widget.currentUser!.prenom;
      _emailController.text = widget.currentUser!.email;
      _phoneController.text = widget.currentUser!.numeroDeTelephone;
      _selectedCountry = widget.currentUser!.pays;
      _selectedProvince = widget.currentUser!.wilaya;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Formulaire de reservation',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF6E4B2F),
      ),
      backgroundColor: const Color.fromARGB(255, 232, 196, 167),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Step 1: Select Reservation Dates
          _buildStep1(screenWidth, screenHeight),
          // Step 2: Personal Information
          _buildStep2(screenWidth, screenHeight),
          // Step 4: Payment (directly after Step 2)
          _buildStep4(screenWidth, screenHeight),
          // Step 5: Confirmation
          _buildStep5(screenWidth, screenHeight),
        ],
      ),
    );
  }

  // Step 1: Select Reservation Dates
  Widget _buildStep1(double screenWidth, double screenHeight) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Étape 1: Sélectionner la date de la Reservation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6E4B2F),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          TextFormField(
            controller: _startDateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Date début de Reservation',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              suffixIcon: const Icon(Icons.calendar_today),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                setState(() {
                  _startDateController.text =
                      "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                });
              }
            },
          ),
          SizedBox(height: screenHeight * 0.02),
          TextFormField(
            controller: _endDateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Date fin de Reservation',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              suffixIcon: const Icon(Icons.calendar_today),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                setState(() {
                  _endDateController.text =
                      "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                });
              }
            },
          ),
          SizedBox(height: screenHeight * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the RoomDetailsPage
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.02,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Annuler',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_startDateController.text.isNotEmpty &&
                      _endDateController.text.isNotEmpty) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Veuillez remplir toutes les dates')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6E4B2F),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.02,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Suivant',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Step 2: Personal Information
  Widget _buildStep2(double screenWidth, double screenHeight) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Étape 2: Informations Personnelles',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6E4B2F),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            // Nom
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nom',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre nom';
                }
                return null;
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            // Prénom
            TextFormField(
              controller: _surnameController,
              decoration: InputDecoration(
                labelText: 'Prénom',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre prénom';
                }
                return null;
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            // Email
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre email';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Veuillez entrer un email valide';
                }
                return null;
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            // Téléphone
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Téléphone',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre numéro de téléphone';
                }
                return null;
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            // Adresse d'habitat
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Pays',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              value: _selectedCountry,
              hint: const Text('Sélectionner votre pays'),
              items: const [
                DropdownMenuItem(value: 'Algérie', child: Text('Algérie')),
                DropdownMenuItem(value: 'France', child: Text('France')),
                DropdownMenuItem(value: 'USA', child: Text('USA')),
                DropdownMenuItem(value: 'Allemagne', child: Text('Allemagne')),
                // Ajoute d'autres pays si besoin
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCountry = value;
                  if (_selectedCountry != 'Algérie') {
                    _selectedIdType = null;
                    _selectedProvince = null;
                  }
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez sélectionner votre pays';
                }
                return null;
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            // Wilaya (si pays == Algérie)
            if (_selectedCountry == 'Algérie')
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Wilaya',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                value: _selectedProvince,
                hint: const Text('Sélectionner votre Wilaya'),
                items: [
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
                ]
                    .map((wilaya) =>
                        DropdownMenuItem(value: wilaya, child: Text(wilaya)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedProvince = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner votre wilaya';
                  }
                  return null;
                },
              ),
            SizedBox(height: screenHeight * 0.02),
            // Type de document
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Type de document',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              value: _selectedIdType,
              items: const [
                DropdownMenuItem(
                  value: 'Carte Nationale',
                  child: Text('Carte Nationale'),
                ),
                DropdownMenuItem(
                  value: 'Passport',
                  child: Text('Passport'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedIdType = value;
                  _showIdInput = true;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez sélectionner un type de document';
                }
                return null;
              },
            ),
            SizedBox(height: screenHeight * 0.02),
            // Input for document number
            if (_selectedIdType == 'Carte Nationale')
              TextFormField(
                controller: _idNumberController,
                decoration: InputDecoration(
                  labelText: 'Numéro de la Carte Nationale',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le numéro de la Carte Nationale';
                  }
                  return null;
                },
              ),
            if (_selectedIdType == 'Passport')
              TextFormField(
                controller: _idNumberController,
                decoration: InputDecoration(
                  labelText: 'Numéro de Passport',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le numéro de Passport';
                  }
                  return null;
                },
              ),
            SizedBox(height: screenHeight * 0.03),

            // Demandes Spéciales
            const Text(
              'Demandes Spéciales',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            CheckboxListTile(
              title: const Text('Lit bébé'),
              value: _litBebe,
              onChanged: (value) {
                setState(() {
                  _litBebe = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Étage élevé'),
              value: _etageEleve,
              onChanged: (value) {
                setState(() {
                  _etageEleve = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Autres'),
              value: _autres,
              onChanged: (value) {
                setState(() {
                  _autres = value!;
                });
              },
            ),
            if (_autres)
              TextFormField(
                controller: _specialRequestController,
                decoration: InputDecoration(
                  labelText: 'Autres Demandes',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                maxLines: 3,
              ),

            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: screenHeight * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Précédent',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Veuillez remplir tous les champs obligatoires'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6E4B2F),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: screenHeight * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Suivant',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Step 4: Payment
  Widget _buildStep4(double screenWidth, double screenHeight) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Étape 4: Paiement',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6E4B2F),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),

          // Dropdown for Payment Method
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Mode de Paiement',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            value: _selectedPaymentMethod,
            items: const [
              DropdownMenuItem(
                value: 'Carte Bancaire',
                child: Text('Par Carte Bancaire'),
              ),
              DropdownMenuItem(
                value: 'Virement',
                child: Text('Par Virement'),
              ),
              DropdownMenuItem(
                value: 'Cheque',
                child: Text('Par Chèque'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _selectedPaymentMethod =
                    value; // Update the selected payment method
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez sélectionner un mode de paiement';
              }
              return null;
            },
          ),
          SizedBox(height: screenHeight * 0.02),

          // Display fields for "Carte Bancaire"
          if (_selectedPaymentMethod == 'Carte Bancaire') ...[
            // Card Number
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Numéro de la Carte',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: '1234 5678 9012 3456',
              ),
              maxLength: 16,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer le numéro de la carte';
                }
                if (value.length < 15 || value.length > 16) {
                  return 'Le numéro de la carte doit contenir 15 ou 16 chiffres';
                }
                return null;
              },
            ),
            SizedBox(height: screenHeight * 0.02),

            // Expiration Date
            TextFormField(
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                labelText: 'Date d\'Expiration (MM/AA)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: 'MM/AA',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer la date d\'expiration';
                }
                if (!RegExp(r'^(0[1-9]|1[0-2])\/\d{2}$').hasMatch(value)) {
                  return 'Format invalide. Utilisez MM/AA';
                }
                return null;
              },
            ),
            SizedBox(height: screenHeight * 0.02),

            // CVV
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Cryptogramme Visuel (CVV)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: '123',
              ),
              maxLength: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer le CVV';
                }
                if (value.length < 3 || value.length > 4) {
                  return 'Le CVV doit contenir 3 ou 4 chiffres';
                }
                return null;
              },
            ),
            SizedBox(height: screenHeight * 0.02),

            // Cardholder Name
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nom du Titulaire de la Carte',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: 'Tel qu\'inscrit sur la carte',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer le nom du titulaire de la carte';
                }
                return null;
              },
            ),
            SizedBox(height: screenHeight * 0.02),

            // Save Card for Future Payments
            CheckboxListTile(
              title: const Text(
                  'Enregistrer cette carte pour les paiements futurs'),
              value: _saveCardForFuture,
              onChanged: (value) {
                setState(() {
                  _saveCardForFuture = value ?? false;
                });
              },
            ),
          ],

          SizedBox(height: screenHeight * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.02,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Précédent',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6E4B2F),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.02,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Suivant',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Step 5: Confirmation
  Widget _buildStep5(double screenWidth, double screenHeight) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Étape 5: Confirmation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6E4B2F),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          // Affichage des dates de réservation
          const Text(
            'Dates de réservation',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text('Date début : ${_startDateController.text}'),
          Text('Date fin : ${_endDateController.text}'),

          SizedBox(height: screenHeight * 0.02),

          // Affichage des informations de la chambre sélectionnée
          const Text(
            'Chambre à réserver',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          if (widget.selectedRoom != null) ...[
            Text('Nom : ${widget.selectedRoom!.name}'),
            Text('Type : ${widget.selectedRoom!.type}'),
            Text('Prix : ${widget.selectedRoom!.price.toStringAsFixed(2)} DZD'),
          ] else
            const Text('Aucune chambre sélectionnée.'),
          SizedBox(height: screenHeight * 0.02),

          // Display personal information
          const Text(
            'Informations Personnelles',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text('Nom: ${_nameController.text}'),
          Text('Prénom: ${_surnameController.text}'),
          Text('Email: ${_emailController.text}'),
          Text('Pays: $_selectedCountry'),
          if (_selectedCountry == 'Algérie') Text('Wilaya: $_selectedProvince'),
          Text('Téléphone: ${_phoneController.text}'),

          Text('Type de document: $_selectedIdType'),
          if (_selectedIdType == 'Carte Nationale')
            Text('Numéro de la Carte Nationale: ${_idNumberController.text}'),
          if (_selectedIdType == 'Passport')
            Text('Numéro de Passport: ${_idNumberController.text}'),
          SizedBox(height: screenHeight * 0.02),

          // Display special requests
          const Text(
            'Demandes Spéciales',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (_litBebe) const Text('- Lit bébé'),
          if (_etageEleve) const Text('- Étage élevé'),
          if (_autres) Text('- Autres: ${_specialRequestController.text}'),
          SizedBox(height: screenHeight * 0.02),

          // Display payment method
          const Text(
            'Mode de Paiement',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('Mode de Paiement: $_selectedPaymentMethod'),

          SizedBox(height: screenHeight * 0.04),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigate back to a specific step
                  _pageController.jumpToPage(0); // Example: Go to Step 1
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.02,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Modifier',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Finalize the reservation
                  _finaliserReservation();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.02,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Finaliser la Réservation',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _finaliserReservation() async {
    final url = Uri.parse('http://localhost:5000/api/reservation');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "dateDebut": _startDateController.text,
        "dateFin": _endDateController.text,
        "demandesSpeciales": _specialRequestController.text,
        "typeDocument": _selectedIdType,
        "numDocChoisis": _idNumberController.text,
        "roomName": widget.selectedRoom?.name,
        "roomType": widget.selectedRoom?.type,
        "userEmail": _emailController.text,
        "modePayment": _selectedPaymentMethod,
      }),
    );
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Réservation finalisée avec succès!')),
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
    _startDateController.dispose();
    _endDateController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _specialRequestController.dispose();
    _idNumberController.dispose();
    _transportDateController.dispose();
    _transportTimeController.dispose();
    super.dispose();
  }
}
