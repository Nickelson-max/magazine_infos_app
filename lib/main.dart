import 'package:flutter/material.dart';
import 'views/redacteurs_interface.dart'; // Importation de l'interface utilisateur

void main() {
  
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MonApplication());
}


class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Gestion des Rédacteurs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      
        primarySwatch: Colors.pink,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      
      home: const RedacteursInterface(),
    );
  }
}