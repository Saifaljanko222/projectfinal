import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sqflite/sqflite.dart' as sqflite;

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static sqflite.Database? _database;

  Future<sqflite.Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  DatabaseHelper.internal();

  Future<sqflite.Database> initDatabase() async {
    Directory directory =
        await path_provider.getApplicationDocumentsDirectory();
    final dbPath = path.join(directory.path, 'favorites.db');

    final database = await sqflite.openDatabase(
      dbPath,
      version: 1,
      onCreate: (sqflite.Database db, int version) async {
        await db.execute(
          'CREATE TABLE favorites (id INTEGER PRIMARY KEY, name TEXT, price REAL, image TEXT)',
        );
      },
    );

    return database;
  }

  Future<int> insertFavorite(Map<String, dynamic> favorite) async {
    final db = await database;
    final List<Map<String, dynamic>> existingFavorites = await db.query(
      'favorites',
      where: 'name = ? AND price = ? AND image = ?',
      whereArgs: [favorite['name'], favorite['price'], favorite['image']],
    );
    if (existingFavorites.isNotEmpty) {
      // Product already inserted as a favorite
      return 0;
    } else {
      // Product not found, perform the insertion
      return await db.insert('favorites', favorite);
    }
  }

  Future<int> removeFavorite(int id) async {
    final db = await database;
    return await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return await db.query('favorites');
  }
}
