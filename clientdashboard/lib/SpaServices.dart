import 'package:flutter/material.dart';
import 'Models.dart';

class SpaServicesPage extends StatelessWidget {
  const SpaServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Services de Spa',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF6E4B2F),
      ),
      backgroundColor: const Color.fromARGB(255, 232, 196, 167),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: spaServices.length,
        itemBuilder: (context, index) {
          final service = spaServices[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image du service
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          service.imagePath,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Détails du service
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.nom,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              service.description,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Heures : ${service.heures}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Équipe : ${service.equipe}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${service.prix.toStringAsFixed(2)} DZD',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                                height:
                                    30), // Pour laisser de la place au bouton
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Bouton en bas à droite
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: ElevatedButton(
                      onPressed: () {
                        // Action du bouton
                        showDialog(
                          context: context,
                          builder: (context) =>
                              _SpaOrderDialog(service: service),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8C6239), // Brun doux
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Réserver',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SpaOrderDialog extends StatefulWidget {
  final SpaService service;
  const _SpaOrderDialog({required this.service});

  @override
  State<_SpaOrderDialog> createState() => _SpaOrderDialogState();
}

class _SpaOrderDialogState extends State<_SpaOrderDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _ibanController = TextEditingController();
  String? _paymentMethod;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Réserver : ${widget.service.nom}'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Entrez votre nom' : null,
              ),
              TextFormField(
                controller: _prenomController,
                decoration: const InputDecoration(labelText: 'Prénom'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Entrez votre prénom'
                    : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration:
                    const InputDecoration(labelText: 'Mode de paiement'),
                value: _paymentMethod,
                items: const [
                  DropdownMenuItem(
                    value: 'Carte Bancaire',
                    child: Text('Carte Bancaire'),
                  ),
                  DropdownMenuItem(
                    value: 'Virement',
                    child: Text('Virement'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Sélectionnez un mode de paiement' : null,
              ),
              if (_paymentMethod == 'Carte Bancaire') ...[
                const SizedBox(height: 10),
                TextFormField(
                  controller: _cardNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Numéro de carte bancaire',
                    hintText: '1234 5678 9012 3456',
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 16,
                  validator: (value) {
                    if (_paymentMethod == 'Carte Bancaire' &&
                        (value == null || value.isEmpty)) {
                      return 'Entrez le numéro de carte';
                    }
                    return null;
                  },
                ),
              ],
              if (_paymentMethod == 'Virement') ...[
                const SizedBox(height: 10),
                TextFormField(
                  controller: _ibanController,
                  decoration: const InputDecoration(
                    labelText: 'IBAN',
                    hintText: 'Entrer votre IBAN',
                  ),
                  validator: (value) {
                    if (_paymentMethod == 'Virement' &&
                        (value == null || value.isEmpty)) {
                      return 'Entrez votre IBAN';
                    }
                    return null;
                  },
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8C6239),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Réservation envoyée avec succès !')),
              );
            }
          },
          child: const Text(
            'Réserver',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
