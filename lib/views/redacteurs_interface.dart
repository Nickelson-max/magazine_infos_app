import 'package:flutter/material.dart';
import '../modele/redacteur.dart';
import '../services/database_manager.dart';

// 15. Création de la classe RedacteursInterface qui étend StatefulWidget
class RedacteursInterface extends StatefulWidget {
  const RedacteursInterface({super.key});

  @override
  State<RedacteursInterface> createState() => _RedacteursInterfaceState();
}

// 16. Créer la classe d'état privée _RedacteursInterfaceState
class _RedacteursInterfaceState extends State<RedacteursInterface> {
  // 17. Prévoir une liste de rédacteurs à afficher dans l'écran
  List<Redacteur> _redacteursList = [];

  // Instance du gestionnaire de base de données
  final DatabaseManager _dbManager = DatabaseManager();

  // 18. Déclarer des contrôleurs de texte pour les champs de saisie
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Clé globale pour la validation du formulaire
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _chargerRedacteurs(); // Chargement initial des données au démarrage
  }

  // Méthode corrigée pour charger les rédacteurs depuis SQLite
  Future<void> _chargerRedacteurs() async {
    final donnees = await _dbManager.getAllRedacteurs();
    setState(() {
      _redacteursList = donnees;
    });
  }

  // Méthode pour vider les champs après insertion
  void _viderChamps() {
    _nomController.clear();
    _prenomController.clear();
    _emailController.clear();
  }

  @override
  void dispose() {
    // Libération des contrôleurs pour éviter les fuites de mémoire
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    super.dispose();
  }
// 3.2. Boîte de dialogue pour la modification d'un rédacteur
  void _afficherDialogueModification(Redacteur redacteur) {
    final TextEditingController modifNomController = TextEditingController(text: redacteur.nom);
    final TextEditingController modifPrenomController = TextEditingController(text: redacteur.prenom);
    final TextEditingController modifEmailController = TextEditingController(text: redacteur.email);
    final GlobalKey<FormState> modifFormKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modifier le rédacteur'),
          content: Form(
            key: modifFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: modifNomController,
                    decoration: const InputDecoration(labelText: 'Nom'),
                    validator: (value) => value!.trim().isEmpty ? 'Champ obligatoire' : null,
                  ),
                  TextFormField(
                    controller: modifPrenomController,
                    decoration: const InputDecoration(labelText: 'Prénom'),
                    validator: (value) => value!.trim().isEmpty ? 'Champ obligatoire' : null,
                  ),
                  TextFormField(
                    controller: modifEmailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) => value!.trim().isEmpty ? 'Champ obligatoire' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (modifFormKey.currentState!.validate()) {
                  final redacteurModifie = Redacteur(
                    id: redacteur.id,
                    nom: modifNomController.text.trim(),
                    prenom: modifPrenomController.text.trim(),
                    email: modifEmailController.text.trim(),
                  );
                  
                  await _dbManager.updateRedacteur(redacteurModifie);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  _chargerRedacteurs(); // Actualiser l'affichage
                  
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Rédacteur modifié avec succès !')),
                  );
                }
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  // Boîte de dialogue pour confirmer la suppression
  void _afficherDialogueSuppression(int id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Voulez-vous vraiment supprimer ce rédacteur ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Non'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                await _dbManager.deleteRedacteur(id);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                _chargerRedacteurs(); // Actualiser l'affichage
                
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Rédacteur supprimé !')),
                );
              },
              child: const Text('Oui, Supprimer', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    //  Faire retourner par la méthode build un widget Scaffold
    return Scaffold(
    
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: const Text(
          'Gestion des rédacteurs',
          style: TextStyle(color: Colors.white),
        ),
      ),
    
      body: Padding(
        padding: const EdgeInsets.all(8.0),
      
        child: Column(
          children: [
            //Formulaire de saisie enveloppé dans un Form
            Form(
              key: _formKey,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      // Champ Nom
                      TextFormField(
                        controller: _nomController,
                        decoration: const InputDecoration(
                          labelText: 'Nom du rédacteur',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Veuillez entrer un nom';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),

                      // Champ Prénom
                      TextFormField(
                        controller: _prenomController,
                        decoration: const InputDecoration(
                          labelText: 'Prénom du rédacteur',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Veuillez entrer un prénom';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),

                      // Champ Email
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email du rédacteur',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Veuillez entrer un email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Veuillez entrer un email valide';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),

                      // BOUTON : Ajouter un rédacteur
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // Création du nouvel objet rédacteur sans ID
                              final nouveauRedacteur = Redacteur.sansId(
                                nom: _nomController.text.trim(),
                                prenom: _prenomController.text.trim(),
                                email: _emailController.text.trim(),
                              );
                              
                              // Insertion dans la base SQLite
                              await _dbManager.insertRedacteur(nouveauRedacteur);
                              _viderChamps(); // Nettoyage du formulaire
                              _chargerRedacteurs(); // Rafraîchissement de la liste
                              
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Rédacteur ajouté avec succès !')),
                              );
                            }
                          },
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text(
                            'Ajouter un Rédacteur',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Affichage de la liste des rédacteurs existants
            Expanded(
              child: _redacteursList.isEmpty
                  ? const Center(
                      child: Text('Aucun rédacteur enregistré pour le moment.'),
                    )
                  : ListView.builder(
                      itemCount: _redacteursList.length,
                      itemBuilder: (context, index) {
                        final redacteur = _redacteursList[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            // Affichage du Prénom et Nom
                            title: Text('${redacteur.prenom} ${redacteur.nom}'),
                            // Affichage de l'Email
                            subtitle: Text(redacteur.email),
                            // Les icônes d'action à droite (Modifier et Supprimer)
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Bouton de modification
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    // Dialogue de modification
                                    _afficherDialogueModification(redacteur);
                                  },
                                ),
                                // Bouton de suppression
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    // Dialogue de confirmation de suppression
                                    _afficherDialogueSuppression(redacteur.id!);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

}