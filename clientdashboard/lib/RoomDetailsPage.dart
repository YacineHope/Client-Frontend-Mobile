import 'package:flutter/material.dart';
import 'ReservationFormPage.dart';
import 'Models.dart';

class RoomDetailsPage extends StatefulWidget {
  final Room roomDetails;

  const RoomDetailsPage({super.key, required this.roomDetails});

  @override
  _RoomDetailsPageState createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends State<RoomDetailsPage> {
  int _currentImageIndex = 0;
  double _userRating = 0.0; // User's rating
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _problemDetailsController =
      TextEditingController();
  String? _selectedProblem;

  final List<String> _problems = [
    'Manque du nettoyage',
    'Service manquant',
    'Problème de climatisation',
    'Problème de plomberie',
    'Autre',
  ];

  // Example comments for each room
  final Map<String, List<String>> roomComments = {
    'Chambre Standard': [
      'Très confortable et propre.',
      'Le service était excellent.',
      'Un peu bruyant la nuit.',
      'La salle de bain était petite.',
    ],
    'Chambre Supérieur': [
      'Vue magnifique depuis le balcon.',
      'Le lit était très confortable.',
      'Le petit-déjeuner pourrait être amélioré.',
      'Un peu cher pour les services offerts.',
    ],
    'Chambre Deluxe': [
      'Le jacuzzi était incroyable.',
      'Service de chambre rapide et efficace.',
      'La climatisation était bruyante.',
      'Manque de prises électriques près du lit.',
    ],
  };

  @override
  Widget build(BuildContext context) {
    final room = widget.roomDetails;
    final comments = roomComments[room.name] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          room.name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF6E4B2F),
        // Place the report icon to the right using actions
        actions: [
          IconButton(
            icon: const Icon(Icons.report_problem, color: Colors.white),
            tooltip: 'Signaler la chambre',
            onPressed: () {
              _showReportDialog(context);
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 232, 196, 167),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container with arrows
            Stack(
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Image.asset(
                    room.images[_currentImageIndex],
                    fit: BoxFit.cover,
                  ),
                ),
                // Left arrow
                Positioned(
                  left: 10,
                  top: 100,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _currentImageIndex =
                            (_currentImageIndex - 1 + room.images.length) %
                                room.images.length;
                      });
                    },
                  ),
                ),
                // Right arrow
                Positioned(
                  right: 10,
                  top: 100,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _currentImageIndex =
                            (_currentImageIndex + 1) % room.images.length;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Room type and price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.type,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${room.price.toStringAsFixed(2)} DZD / nuit',
                    style: const TextStyle(fontSize: 18, color: Colors.green),
                  ),
                  const SizedBox(height: 10),
                  // Ratings
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        color: index < room.rating.floor()
                            ? Colors.amber
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Equipment
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Équipements',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...room.equipment.map((equip) => Row(
                        children: [
                          const Icon(Icons.check, color: Colors.green),
                          const SizedBox(width: 10),
                          Text(equip),
                        ],
                      )),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Reserver maintenant button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the ReservationFormPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReservationFormPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6E4B2F),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Réserver maintenant',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Comments Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Commentaires',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...comments.map((comment) => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            const Icon(Icons.comment, color: Colors.grey),
                            const SizedBox(width: 10),
                            Expanded(child: Text(comment)),
                          ],
                        ),
                      )),
                  const SizedBox(height: 20),
                  const Text(
                    'Ajouter un commentaire',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      labelText: 'Écrire un commentaire',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Noter la chambre',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: List.generate(
                      5,
                      (index) => IconButton(
                        icon: Icon(
                          Icons.star,
                          color:
                              index < _userRating ? Colors.amber : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _userRating = index + 1.0;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_commentController.text.isNotEmpty) {
                        setState(() {
                          comments.add(_commentController.text);
                          _commentController.clear();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Commentaire ajouté avec succès!'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6E4B2F),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Soumettre',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Signaler un problème'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sélectionnez un problème :',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ..._problems.map((problem) {
                  return RadioListTile<String>(
                    title: Text(problem),
                    value: problem,
                    groupValue: _selectedProblem,
                    onChanged: (value) {
                      setState(() {
                        _selectedProblem = value;
                      });
                    },
                  );
                }),
                const SizedBox(height: 10),
                const Text(
                  'Détails du problème :',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _problemDetailsController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Décrivez le problème en détail...',
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_selectedProblem != null ||
                    _problemDetailsController.text.isNotEmpty) {
                  Navigator.pop(context); // Close the dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Merci pour votre réponse, l\'administrateur réglera ce problème à l\'avenir.',
                      ),
                    ),
                  );
                  // Clear the inputs
                  setState(() {
                    _selectedProblem = null;
                    _problemDetailsController.clear();
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Veuillez sélectionner ou décrire un problème.'),
                    ),
                  );
                }
              },
              child: const Text('Envoyer'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    _problemDetailsController.dispose();
    super.dispose();
  }
}
