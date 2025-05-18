class User {
  final String nom;
  final String prenom;
  final String? pays;
  final String? wilaya;
  final String email;
  final String numeroDeTelephone;

  User({
    required this.nom,
    required this.prenom,
    this.pays,
    this.wilaya,
    required this.email,
    required this.numeroDeTelephone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nom: json['nom'],
      prenom: json['prenom'],
      pays: json['pays'],
      wilaya: json['wilaya'],
      email: json['email'],
      numeroDeTelephone: json['numeroDeTelephone'],
    );
  }
}

class Room {
  final String name;
  final String type;
  final double rating;
  final List<String> images;
  final String description;
  final double price; // Price in DZD
  final List<String> equipment;

  Room({
    required this.name,
    required this.type,
    required this.rating,
    required this.images,
    required this.description,
    required this.price,
    required this.equipment,
  });
}

// Conversion rate: 1 USD = 135 DZD
const double conversionRate = 135.0;

// Example list of rooms
final List<Room> rooms = [
  Room(
    name: 'Chambre 1001',
    type: 'Chambre Standard',
    rating: 4.5,
    images: ['assets/rooms/room1001.png', 'assets/rooms/room1002.png'],
    description: 'Chambre comfortable avec lit double et salle de bain privée.',
    price: 100.0 * conversionRate, // Converted to DZD
    equipment: [
      'Lit comfortable (double)',
      'Table de chevet avec lampe de lecture',
      'Television avec chaines nationales et internationales',
      'Wi-Fi gratuit',
    ],
  ),
  Room(
    name: 'Chambre 1002',
    type: 'Chambre Supérieur',
    rating: 4.8,
    images: ['assets/rooms/room1003.png', 'assets/rooms/room1004.png'],
    description: 'Chambre spacieuse avec vue sur la mer et balcon privé.',
    price: 29878, // Converted to DZD
    equipment: [
      'Lit king-size avec matelas premium',
      'Balcon privé avec vue',
      'Téléviseur grand écran avec Netflix',
      'Mini-bar rempli (payant)',
    ],
  ),
  Room(
    name: 'Chambre 1003',
    type: 'Chambre Deluxe',
    rating: 4.7,
    images: ['assets/rooms/room1005.png', 'assets/rooms/room1006.png'],
    description: 'Suite luxueuse avec salon séparé et jacuzzi privé.',
    price: 37347.5, // Converted to DZD
    equipment: [
      'Machine à espresso (Nespresso)',
      'Plancher chauffant en salle de bain',
      'Douche à effet pluie',
      'Salle de bain en marbre avec double vasque',
    ],
  ),
  Room(
    name: 'Chambre 1004',
    type: 'Suite Junior',
    rating: 4.6,
    images: [
      'assets/rooms/room1007.png',
      'assets/rooms/room1008.png',
      'assets/rooms/room1009.png'
    ],
    description: 'Suite luxueuse avec salon séparé et jacuzzi privé.',
    price: 22408.5, // Converted to DZD
    equipment: [
      'Bureau avec imprimante/scanner',
      'Douche à effet pluie et produits de bain exclusifs',
      'Salle de bain en marbre avec double vasque',
      'Télévision dans la salle de bain',
    ],
  ),
  Room(
    name: 'Chambre 1005',
    type: 'Chambre Deluxe',
    rating: 4.6,
    images: [
      'assets/rooms/room1007.png',
      'assets/rooms/room1008.png',
      'assets/rooms/room1009.png'
    ],
    description: 'A deluxe room with premium furnishings and amenities.',
    price: 22408.5, // Converted to DZD
    equipment: [
      'Téléviseur grand écran avec Netflix',
      'Mini-bar rempli (payant)',
      'Machine à espresso (Nespresso)',
      'Plancher chauffant en salle de bain',
    ],
  ),
  Room(
    name: 'Chambre 1006',
    type: 'Deluxe Room',
    rating: 4.6,
    images: [
      'assets/rooms/room1007.png',
      'assets/rooms/room1008.png',
      'assets/rooms/room1009.png'
    ],
    description: 'A deluxe room with premium furnishings and amenities.',
    price: 22408.5, // Converted to DZD
    equipment: [
      'Service de majordome',
      'Choix d\'oreillers (femme, moelleux, mémoire de forme)',
      'Tablette de contrôle (lumières, climatisation, rideaux)',
      'Bureau avec imprimante/scanner',
    ],
  ),
  Room(
    name: 'Chambre 1007',
    type: 'Chambre Supérieur',
    rating: 4.6,
    images: [
      'assets/rooms/room1007.png',
      'assets/rooms/room1008.png',
      'assets/rooms/room1009.png'
    ],
    description: 'Chambre spacieuse avec vue sur la mer et balcon privé.',
    price: 22408.5, // Converted to DZD
    equipment: [
      'Machine à espresso (Nespresso)',
      'Plancher chauffant en salle de bain',
      'Douche à effet pluie',
      'Salle de bain en marbre avec double vasque',
    ],
  ),
  Room(
    name: 'Chambre 1008',
    type: 'Chambre Standard',
    rating: 4.6,
    images: [
      'assets/rooms/room1007.png',
      'assets/rooms/room1008.png',
      'assets/rooms/room1009.png'
    ],
    description: 'Chambre comfortable avec lit double et salle de bain privée.',
    price: 22408.5, // Converted to DZD
    equipment: [
      'Rideaux occultants',
      'Mini-réfrigérateur',
      'Bouilloire / Machine à café',
      'Prises électriques et ports USB',
    ],
  ),
  Room(
    name: 'Chambre 1009',
    type: 'Chambre Deluxe',
    rating: 4.6,
    images: [
      'assets/rooms/room1007.png',
      'assets/rooms/room1008.png',
      'assets/rooms/room1009.png'
    ],
    description: 'A deluxe room with premium furnishings and amenities.',
    price: 22408.5, // Converted to DZD
    equipment: [
      'Mini-bar rempli (payant)',
      'Produits de toilette haut de gamme',
      'Enceinte Bluetooth',
      'Machine à espresso (Nespresso)',
    ],
  ),
];

class RestaurationService {
  final String imagePath; // Path to the image of the service
  final String nom; // Name of the service (e.g., Steak Frites)
  final String description; // Description of the service
  final double prix; // Price of the service in DZD

  RestaurationService({
    required this.imagePath,
    required this.nom,
    required this.description,
    required this.prix,
  });
}

// Sample list of restauration services
final List<RestaurationService> restaurationServices = [
  RestaurationService(
    imagePath: 'assets/services/restauration/Steak Frites.webp',
    nom: 'Steak Frites',
    description: 'Un délicieux steak accompagné de frites croustillantes.',
    prix: 1500.0,
  ),
  RestaurationService(
    imagePath: 'assets/services/restauration/Pizza Margherita.webp',
    nom: 'Pizza Margherita',
    description: 'Pizza classique avec sauce tomate, mozzarella et basilic.',
    prix: 1000.0,
  ),
  RestaurationService(
    imagePath: 'assets/services/restauration/Tiramisu.webp',
    nom: 'Tiramisu',
    description: 'Dessert italien classique avec mascarpone et café.',
    prix: 700.0,
  ),
  RestaurationService(
    imagePath: 'assets/services/restauration/Burger Gourmet.webp',
    nom: 'Burger Gourmet',
    description: 'Burger juteux avec fromage, laitue et tomate.',
    prix: 1300.0,
  ),
];

class GymService {
  final String imagePath; // Chemin de l'image du service
  final String nom; // Nom du service (ex: "Fitness Cardio")
  final String description; // Description du service
  final String heures; // Heures d'ouverture (ex: "08:00 - 22:00")
  final double prix; // Prix du service en DZD
  final String equipe; // Liste des équipements disponibles

  GymService({
    required this.imagePath,
    required this.nom,
    required this.description,
    required this.heures,
    required this.prix,
    required this.equipe,
  });
}

// Exemple de liste de services de gym
final List<GymService> gymServices = [
  GymService(
    imagePath: 'assets/services/gym/Cardio Training.webp',
    nom: 'Cardio Training',
    description: 'Accès aux équipements de cardio-training modernes.',
    heures: '6h-22h',
    prix: 1200.0,
    equipe: 'Équipe Fitness',
  ),
  GymService(
    imagePath: 'assets/services/gym/Musculation.webp',
    nom: 'Musculation',
    description:
        'Salle équipée pour la musculation et le renforcement musculaire.',
    heures: '7h-21h',
    prix: 1500.0,
    equipe: 'Équipe Bodybuilding',
  ),
  GymService(
    imagePath: 'assets/services/gym/youga.webp',
    nom: 'Yoga',
    description: 'Séances de yoga en groupe avec coach certifié.',
    heures: '8h-20h',
    prix: 1000.0,
    equipe: 'Équipe Relaxation',
  ),
];

class SpaService {
  final String imagePath; // Chemin de l'image du service
  final String nom; // Nom du service (ex: "Massage Relaxant")
  final String description; // Description du service
  final String heures; // Heures d'ouverture (ex: "09:00 - 20:00")
  final double prix; // Prix du service en DZD
  final String equipe; // Équipe ou équipements disponibles

  SpaService({
    required this.imagePath,
    required this.nom,
    required this.description,
    required this.heures,
    required this.prix,
    required this.equipe,
  });
}

// Exemple de liste de services de spa
final List<SpaService> spaServices = [
  SpaService(
    imagePath: 'assets/services/spa/massage.webp',
    nom: 'Massage Relaxant',
    description: 'Massage complet du corps pour une détente absolue.',
    heures: '10h-20h',
    prix: 2500.0,
    equipe: 'Équipe Bien-être',
  ),
  SpaService(
    imagePath: 'assets/services/spa/visage soign.webp',
    nom: 'Soin du Visage',
    description: 'Soin du visage personnalisé avec produits naturels.',
    heures: '9h-18h',
    prix: 1800.0,
    equipe: 'Équipe Beauté',
  ),
  SpaService(
    imagePath: 'assets/services/spa/soin des pieds.webp',
    nom: 'Soin des Pieds',
    description: 'Soin complet des pieds avec gommage et massage.',
    heures: '11h-19h',
    prix: 1200.0,
    equipe: 'Équipe Podologie',
  ),
];
