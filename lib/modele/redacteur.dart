class Redacteur {
  // Attributs de la classe (id est nullable car il sera auto-incrémenté par la base)
  int? id;
  String nom;
  String prenom;
  String email;

  // 1. Constructeur avec tous les attributs
  Redacteur({
    this.id,
    required this.nom,
    required this.prenom,
    required this.email,
  });

  // 2. Constructeur sans l'attribut id (utilisé lors de l'ajout d'un nouveau rédacteur)
  Redacteur.sansId({
    required this.nom,
    required this.prenom,
    required this.email,
  });

  // 3. Méthode pour convertir un objet Redacteur en Map (indispensable pour l'insertion dans SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
    };
  }

  // 4. Méthode pour reconstruire un objet Redacteur à partir d'une ligne de la base de données
  factory Redacteur.fromMap(Map<String, dynamic> map) {
    return Redacteur(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
    );
  }
}