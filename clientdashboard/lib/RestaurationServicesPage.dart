import 'package:flutter/material.dart';
import 'Models.dart';

class RestaurationServicesPage extends StatelessWidget {
  const RestaurationServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Restauration Services',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF6E4B2F),
      ),
      backgroundColor: const Color.fromARGB(255, 232, 196, 167),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: restaurationServices.length,
        itemBuilder: (context, index) {
          final service = restaurationServices[index];
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
                    children: [
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
                              '${service.prix.toStringAsFixed(2)} DZD',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 30),
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
                        showDialog(
                          context: context,
                          builder: (context) => _OrderDialog(service: service),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8C6239),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Commander',
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

class _OrderDialog extends StatefulWidget {
  final RestaurationService service;
  const _OrderDialog({required this.service});

  @override
  State<_OrderDialog> createState() => _OrderDialogState();
}

class _OrderDialogState extends State<_OrderDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _ibanController = TextEditingController();
  String? _paymentMethod;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Commander : ${widget.service.nom}'),
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
              // Ici tu peux envoyer la commande à la base ou afficher un message de succès
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Commande envoyée avec succès !')),
              );
            }
          },
          child: const Text(
            'Commander',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
