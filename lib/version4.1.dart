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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gwo imaj la anlè nèt
            Image.asset(
              'assets/images/magazineInfo.jpg', 
              width: double.infinity, 
              height: 250, 
              fit: BoxFit.cover,
            ),
            
            // Zòn Tit ak Sous-tit
            const Padding(
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
            ),
            
            // Zòn Tèks Deskripsyon
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Magazine Infos est bien plus qu\'un simple magazine d\'informations. C\'est votre passerelle vers le monde, une source incontournable de connaissances et d\'actualités soigneusement sélectionnées pour vous éclairer sur les médias mondiaux, la culture, la science, le divertissement et bien plus encore.',
                style: TextStyle(fontSize: 15, height: 1.4, color: Colors.black87),
                textAlign:TextAlign.justify,
              ),
            ),
            
            // Zòn 3 Bouton Ikòn yo (TEL, MAIL, PARTAGE)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildIconAction(Icons.phone, 'TEL'),
                  _buildIconAction(Icons.email, 'MAIL'),
                  _buildIconAction(Icons.share, 'PARTAGE'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tu as cliqué dessus')),
          );
        },
        backgroundColor: Colors.pink,
        child: const Text('Click'),
      ),
    );
  }

  // Ti fonksyon pou konstwi bouton ikòn yo
  Widget _buildIconAction(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.pink, size: 26),
        const SizedBox(height: 5),
        Text(
          label, 
          style: const TextStyle(color: Colors.pink, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}