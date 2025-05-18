import 'package:flutter/material.dart';

class ReservationHistoriquePage extends StatelessWidget {
  final List<ReservationHistorique> historiqueList;

  const ReservationHistoriquePage({super.key, required this.historiqueList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique des réservations',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF6E4B2F),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 232, 196, 167),
      body: historiqueList.isEmpty
          ? const Center(child: Text("Aucune réservation effectuée."))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: historiqueList.length,
              itemBuilder: (context, index) {
                final reservation = historiqueList[index];
                final date = reservation.dateReservation;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date style calendrier
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF8C6239),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Column(
                                children: [
                                  Text(
                                    "${date.day}".padLeft(2, '0'),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    "${_monthName(date.month)}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "${date.year}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Chambre : ${reservation.roomName} (${reservation.roomType})",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                      "Prix : ${reservation.roomPrice.toStringAsFixed(2)} DZD"),
                                  Text("Date début : ${reservation.dateDebut}"),
                                  Text("Date fin : ${reservation.dateFin}"),
                                  Text(
                                      "Nom : ${reservation.nom} ${reservation.prenom}"),
                                  Text("Email : ${reservation.email}"),
                                  Text(
                                      "Mode de paiement : ${reservation.modePaiement}"),
                                  if (reservation.demandesSpeciales != null &&
                                      reservation.demandesSpeciales!.isNotEmpty)
                                    Text(
                                        "Demandes spéciales : ${reservation.demandesSpeciales}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  String _monthName(int month) {
    const months = [
      "Jan",
      "Fév",
      "Mar",
      "Avr",
      "Mai",
      "Juin",
      "Juil",
      "Aoû",
      "Sep",
      "Oct",
      "Nov",
      "Déc"
    ];
    return months[month - 1];
  }
}

// Modèle pour l'historique d'une réservation
class ReservationHistorique {
  final DateTime dateReservation;
  final String roomName;
  final String roomType;
  final double roomPrice;
  final String dateDebut;
  final String dateFin;
  final String nom;
  final String prenom;
  final String email;
  final String modePaiement;
  final String? demandesSpeciales;

  ReservationHistorique({
    required this.dateReservation,
    required this.roomName,
    required this.roomType,
    required this.roomPrice,
    required this.dateDebut,
    required this.dateFin,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.modePaiement,
    this.demandesSpeciales,
  });
}
