import 'package:flutter/material.dart';
import 'views/redacteurs_interface.dart'; // Importation de l'interface utilisateur

void main() {
  // Garantir que les services Flutter (et les liaisons binaires) sont bien initialisés avant de lancer l'application
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MonApplication());
}

// 11. Créer un StatelessWidget nommé MonApplication
class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    // 12. Faire retourner par ce widget un MaterialApp
    return MaterialApp(
      // 13. Utiliser un titre d'application explicite
      title: 'Gestion des Rédacteurs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Configuration du thème visuel de l'application (ici avec une couleur rose/fuchsia dominante)
        primarySwatch: Colors.pink,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      // 14. Définir comme page d'accueil le widget RedacteursInterface
      home: const RedacteursInterface(),
    );
  }
}