import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../modele/redacteur.dart';

class DatabaseManager {
  // Instance unique du DatabaseManager (Pattern Singleton)
  static final DatabaseManager _instance = DatabaseManager._internal();
  static Database? _database;

  DatabaseManager._internal();

  factory DatabaseManager() {
    return _instance;
  }

  // Permet de récupérer l'instance active de la base de données
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // 1. Initialisation de la base de données SQLite
  Future<Database> _initDatabase() async {
    // Récupérer le chemin du dossier des bases de données sur l'appareil
    String pathDatabase = join(await getDatabasesPath(), 'redacteurs.db');
    
    // Ouvrir la base de données et appeler la fonction de création
    return await openDatabase(
      pathDatabase,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Fonction interne pour créer la table redacteurs lors du premier lancement
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE redacteurs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT,
        prenom TEXT,
        email TEXT
      )
    ''');
  }

  // 2. CREATE : Insérer un nouveau rédacteur dans la base de données
  Future<int> insertRedacteur(Redacteur redacteur) async {
    Database db = await database;
    // Conversion de l'objet en Map pour SQLite
    return await db.insert('redacteurs', redacteur.toMap());
  }

  // 3. READ : Récupérer tous les rédacteurs de la base de données
  Future<List<Redacteur>> getAllRedacteurs() async {
    Database db = await database;
    // Récupération de toutes les lignes sous forme de liste de Maps
    final List<Map<String, dynamic>> maps = await db.query('redacteurs');
    
    // Conversion de la liste de Maps en liste d'objets Redacteur
    return List.generate(maps.length, (i) {
      return Redacteur.fromMap(maps[i]);
    });
  }

  // 4. UPDATE : Modifier les informations d'un rédacteur existant
  Future<int> updateRedacteur(Redacteur redacteur) async {
    Database db = await database;
    return await db.update(
      'redacteurs',
      redacteur.toMap(),
      where: 'id = ?',
      whereArgs: [redacteur.id],
    );
  }

  // 5. DELETE : Supprimer un rédacteur de la base de données via son ID
  Future<int> deleteRedacteur(int id) async {
    Database db = await database;
    return await db.delete(
      'redacteurs',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Redacteur>> getRedacteurs() async {
    return await getAllRedacteurs();
  }
}