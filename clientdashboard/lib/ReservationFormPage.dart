import 'package:flutter/material.dart';

class ReservationFormPage extends StatefulWidget {
  const ReservationFormPage({super.key});

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
  String? _selectedIdType;
  bool _showIdInput = false;
  String? _selectedTransportMode;
  String? _selectedPaymentMethod;
  bool _saveCardForFuture = false;

  // Additional services
  bool _petitDejeuner = false;
  bool _restaurant = false;
  bool _cafeteria = false;
  bool _massage = false;
  bool _facialCare = false;
  bool _footCare = false;
  bool _parking = false;
  final bool _transportByPlane = false;
  final bool _transportByBus = false;
  final bool _transportByCar = false;
  bool _cardioTraining = false;
  bool _musculation = false;
  bool _yoga = false;

  // Special requests
  bool _litBebe = false;
  bool _etageEleve = false;
  final bool _chambreAntiAllergique = false;
  bool _autres = false;

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
        physics:
            const NeverScrollableScrollPhysics(), // Disable swipe navigation
        children: [
          // Step 1: Select Reservation Dates
          _buildStep1(screenWidth, screenHeight),
          // Step 2: Personal Information
          _buildStep2(screenWidth, screenHeight),
          // Step 3: Additional Services
          _buildStep3(screenWidth, screenHeight),
          // Step 4: Payment (Placeholder for now)
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
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Adresse d\'habitat',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre adresse';
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

  // Step 3: Additional Services
  Widget _buildStep3(double screenWidth, double screenHeight) {
    // Taux de conversion de l'euro vers le dinar algérien
    const double conversionRate = 149.34;

    // Fonction pour convertir les prix
    String convertPriceToDZD(double priceInEuro) {
      final double priceInDZD = priceInEuro * conversionRate;
      return '${priceInDZD.toStringAsFixed(2)} DZD';
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Étape 3: Services Additionnels',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6E4B2F),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),

          // Restauration
          const Text(
            'Restauration',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          CheckboxListTile(
            title: Text('Petit Déjeuner - ${convertPriceToDZD(10)}'),
            value: _petitDejeuner,
            onChanged: (value) {
              setState(() {
                _petitDejeuner = value!;
              });
            },
          ),
          CheckboxListTile(
            title: Text('Restaurant - ${convertPriceToDZD(10)}'),
            value: _restaurant,
            onChanged: (value) {
              setState(() {
                _restaurant = value!;
              });
            },
          ),
          CheckboxListTile(
            title: Text('Cafétéria - ${convertPriceToDZD(10)}'),
            value: _cafeteria,
            onChanged: (value) {
              setState(() {
                _cafeteria = value!;
              });
            },
          ),
          SizedBox(height: screenHeight * 0.02),

          // Spa
          const Text(
            'Spa',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          CheckboxListTile(
            title: Text('Massage - ${convertPriceToDZD(70)} (10h-20h)'),
            value: _massage,
            onChanged: (value) {
              setState(() {
                _massage = value!;
              });
            },
          ),
          CheckboxListTile(
            title: Text('Soins du Visage - ${convertPriceToDZD(50)} (9h-18h)'),
            value: _facialCare,
            onChanged: (value) {
              setState(() {
                _facialCare = value!;
              });
            },
          ),
          CheckboxListTile(
            title: Text('Soins des Pieds - ${convertPriceToDZD(40)} (11h-19h)'),
            value: _footCare,
            onChanged: (value) {
              setState(() {
                _footCare = value!;
              });
            },
          ),
          SizedBox(height: screenHeight * 0.02),

          // Gym
          const Text(
            'Gym',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          CheckboxListTile(
            title: Text('Cardio Training - ${convertPriceToDZD(30)} (6h-22h)'),
            value: _cardioTraining,
            onChanged: (value) {
              setState(() {
                _cardioTraining = value!;
              });
            },
          ),
          CheckboxListTile(
            title: Text('Musculation - ${convertPriceToDZD(40)} (7h-21h)'),
            value: _musculation,
            onChanged: (value) {
              setState(() {
                _musculation = value!;
              });
            },
          ),
          CheckboxListTile(
            title: Text('Yoga - ${convertPriceToDZD(35)} (8h-20h)'),
            value: _yoga,
            onChanged: (value) {
              setState(() {
                _yoga = value!;
              });
            },
          ),
          SizedBox(height: screenHeight * 0.02),

          // Parking
          const Text(
            'Réserver un Parking',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          CheckboxListTile(
            title: Text('Parking - ${convertPriceToDZD(80)}'),
            value: _parking,
            onChanged: (value) {
              setState(() {
                _parking = value!;
              });
            },
          ),
          SizedBox(height: screenHeight * 0.02),

          // Transport
          const Text(
            'Transport',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Mode de Transport',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            value: _selectedTransportMode,
            items: [
              DropdownMenuItem(
                value: 'Par Avion',
                child: Text('Par Avion - ${convertPriceToDZD(150)}'),
              ),
              DropdownMenuItem(
                value: 'Par Voiture',
                child: Text('Par Voiture - ${convertPriceToDZD(100)}'),
              ),
              DropdownMenuItem(
                value: 'Par Bus',
                child: Text('Par Bus - ${convertPriceToDZD(80)}'),
              ),
            ],
            onChanged: (value) {
              setState(() {
                _selectedTransportMode = value;
              });
            },
          ),
          if (_selectedTransportMode != null)
            Column(
              children: [
                SizedBox(height: screenHeight * 0.02),
                // Transport Date
                TextFormField(
                  controller: _transportDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date de Transport',
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
                        _transportDateController.text =
                            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                      });
                    }
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                // Transport Time
                TextFormField(
                  controller: _transportTimeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Heure de Transport',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    suffixIcon: const Icon(Icons.access_time),
                  ),
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        _transportTimeController.text =
                            "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}";
                      });
                    }
                  },
                ),
              ],
            ),
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
                  backgroundColor: const Color.fromARGB(255, 205, 146, 98),
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
    // Conversion rate from Euro to DZD
    const double conversionRate = 149.34;

    // Calculate total price
    double calculateTotalPrice() {
      double totalPrice = 0.0;

      // Add room price (assuming a room price is selected)
      double roomPrice = 100.0; // Replace with the actual room price
      totalPrice += roomPrice;

      // Add additional services prices
      if (_petitDejeuner) totalPrice += 10.0;
      if (_restaurant) totalPrice += 10.0;
      if (_cafeteria) totalPrice += 10.0;
      if (_massage) totalPrice += 70.0;
      if (_facialCare) totalPrice += 50.0;
      if (_footCare) totalPrice += 40.0;
      if (_cardioTraining) totalPrice += 30.0;
      if (_musculation) totalPrice += 40.0;
      if (_yoga) totalPrice += 35.0;
      if (_parking) totalPrice += 80.0;

      // Add transport prices
      if (_selectedTransportMode == 'Par Avion') totalPrice += 150.0;
      if (_selectedTransportMode == 'Par Voiture') totalPrice += 100.0;
      if (_selectedTransportMode == 'Par Bus') totalPrice += 80.0;

      return totalPrice;
    }

    // Convert total price to DZD
    String convertTotalPriceToDZD(double totalPriceInEuro) {
      final double totalPriceInDZD = totalPriceInEuro * conversionRate;
      return '${totalPriceInDZD.toStringAsFixed(2)} DZD';
    }

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

          // Display reservation details
          const Text(
            'Détails de la Réservation',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text('Date début: ${_startDateController.text}'),
          Text('Date fin: ${_endDateController.text}'),
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
          Text('Téléphone: ${_phoneController.text}'),
          Text('Adresse d\'habitat: ${_addressController.text}'),
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

          // Display additional services
          const Text(
            'Services Additionnels',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (_petitDejeuner) const Text('- Petit Déjeuner'),
          if (_restaurant) const Text('- Restaurant'),
          if (_cafeteria) const Text('- Cafétéria'),
          if (_massage) const Text('- Massage'),
          if (_facialCare) const Text('- Soins du Visage'),
          if (_footCare) const Text('- Soins des Pieds'),
          if (_cardioTraining) const Text('- Cardio Training'),
          if (_musculation) const Text('- Musculation'),
          if (_yoga) const Text('- Yoga'),
          if (_parking) const Text('- Parking'),
          if (_selectedTransportMode != null)
            Text('- Transport: $_selectedTransportMode'),
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
          SizedBox(height: screenHeight * 0.02),

          // Display total price
          const Text(
            'Prix Total',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(convertTotalPriceToDZD(calculateTotalPrice())),
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Réservation finalisée avec succès!'),
                    ),
                  );
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
