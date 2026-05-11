import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/product_model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'food_scanner_local.db');

    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cached_products (
        barcode TEXT PRIMARY KEY,
        product_name TEXT NOT NULL,
        brand TEXT,
        image_url TEXT,
        nutri_score TEXT,
        raw_json TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE favorite_products (
        barcode TEXT PRIMARY KEY,
        created_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE scan_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        barcode TEXT NOT NULL,
        scanned_at TEXT NOT NULL
      )
    ''');
  }

  Future<void> cacheProduct(ProductModel product) async {
    final db = await database;

    await db.insert('cached_products', {
      'barcode': product.code,
      'product_name': product.productName,
      'brand': product.brands,
      'image_url': product.imageFrontUrl,
      'nutri_score': product.nutritionGrade,
      'raw_json': jsonEncode(product.toJson()),
      'updated_at': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<ProductModel?> getCachedProduct(String barcode) async {
    final db = await database;

    final rows = await db.query(
      'cached_products',
      where: 'barcode = ?',
      whereArgs: [barcode],
      limit: 1,
    );

    if (rows.isEmpty) return null;

    final rawJson = rows.first['raw_json'] as String;
    final decoded = jsonDecode(rawJson);

    if (decoded is Map<String, dynamic>) {
      return ProductModel.fromJson(decoded);
    }

    return null;
  }

  Future<void> addFavorite(String barcode) async {
    final db = await database;

    await db.insert('favorite_products', {
      'barcode': barcode,
      'created_at': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<void> removeFavorite(String barcode) async {
    final db = await database;

    await db.delete(
      'favorite_products',
      where: 'barcode = ?',
      whereArgs: [barcode],
    );
  }

  Future<List<String>> getFavoriteBarcodes() async {
    final db = await database;

    final rows = await db.query(
      'favorite_products',
      orderBy: 'created_at DESC',
    );

    return rows.map((row) => row['barcode'] as String).toList();
  }

  Future<bool> isFavorite(String barcode) async {
    final db = await database;

    final rows = await db.query(
      'favorite_products',
      where: 'barcode = ?',
      whereArgs: [barcode],
      limit: 1,
    );

    return rows.isNotEmpty;
  }

  Future<void> addScanHistory(String barcode) async {
    final db = await database;

    await db.insert('scan_history', {
      'barcode': barcode,
      'scanned_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<String>> getScanHistoryBarcodes() async {
    final db = await database;

    final rows = await db.query(
      'scan_history',
      orderBy: 'scanned_at DESC',
      limit: 20,
    );

    final seen = <String>{};
    final result = <String>[];

    for (final row in rows) {
      final barcode = row['barcode'] as String;
      if (seen.add(barcode)) {
        result.add(barcode);
      }
    }

    return result;
  }

  Future<void> clearScanHistory() async {
    final db = await database;
    await db.delete('scan_history');
  }
}
