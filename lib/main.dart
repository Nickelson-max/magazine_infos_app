import 'package:flutter/material.dart';

void main() {
  runApp(const MonAppli());
}

class MonAppli extends StatelessWidget {
  const MonAppli({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magazine Infos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const PageAccueil(),
    );
  }
}

class PageAccueil extends StatelessWidget {
  const PageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magazine Infos'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Gwo Imaj la anlè nèt
            PartieBanniere(),
            
            // 2. Pati Tit ak Sous-tit la
            PartieTitre(),
            
            // 3. Pati Gwo Tèks Deskripsyon an
            PartieTexte(),
            
            // 4. Pati Twa bouton Ikòn yo (TEL, MAIL, PARTAGE)
            PartieIcone(),
            
            // 5. Pati De ti imaj Rubrik yo ak bèl tit anba nèt
            PartieRubrique(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tu as cliqué sur le bouton principal')),
          );
        },
        backgroundColor: Colors.pink,
        child: const Text('Click'),
      ),
    );
  }
}

// =========================================================================
// 
// =========================================================================

/// 1. Klas pou Gwo Imaj la
class PartieBanniere extends StatelessWidget {
  const PartieBanniere({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/magazineInfo.jpg',
      width: double.infinity,
      height: 250,
      fit: BoxFit.cover,
    );
  }
}

/// 2. Klas pou Tit la
class PartieTitre extends StatelessWidget {
  const PartieTitre({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bienvenue au Magazine Infos',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          SizedBox(height: 5),
          Text(
            'Votre magazine numérique, votre source d\'inspiration',
            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

/// 3. Klas pou Tèks la
class PartieTexte extends StatelessWidget {
  const PartieTexte({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        'Magazine Infos is bien plus qu\'un simple magazine d\'informations. C\'est votre passerelle vers le monde, une source incontournable de connaissances et d\'actualités soigneusement sélectionnées pour vous éclairer sur les médias mondiaux, la culture, la science, le divertissement et bien plus encore.',
        style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
        textAlign: TextAlign.justify,
      ),
    );
  }
}

/// 4. Klas pou Ikòn yo (Avèk ti aksyon klike sou yo)
class PartieIcone extends StatelessWidget {
  const PartieIcone({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildIconAction(context, Icons.phone, 'TEL', 'Appel au secrétariat lancé...'),
          _buildIconAction(context, Icons.email, 'MAIL', 'Ouverture de votre boîte mail...'),
          _buildIconAction(context, Icons.share, 'PARTAGE', 'Lien de partage copié !'),
        ],
      ),
    );
  }

  Widget _buildIconAction(BuildContext context, IconData icon, String label, String message) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), duration: const Duration(seconds: 1)),
        );
      },
      child: Column(
        children: [
          Icon(icon, color: Colors.pink, size: 26),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(color: Colors.pink, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

/// 5. Klas pou De ti imaj Rubrik yo ak bèl tit
class PartieRubrique extends StatelessWidget {
  const PartieRubrique({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 30.0),
      child: Row(
        children: [
          // Premye Rubrik (Presse)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Dernières Presses', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.pink)),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset('assets/images/presse.jpg', height: 120, width: double.infinity, fit: BoxFit.cover),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          // Dezyèm Rubrik (Mode)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tendances Mode', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.pink)),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset('assets/images/mode.jpg', height: 120, width: double.infinity, fit: BoxFit.cover),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}