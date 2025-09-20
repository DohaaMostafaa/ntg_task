import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../domain/entities/cart_item.dart';

class LocalDatabase {
  static final LocalDatabase _instance = LocalDatabase._internal();
  factory LocalDatabase() => _instance;
  LocalDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'cart.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE cart(
            productId INTEGER PRIMARY KEY,
            title TEXT,
            category TEXT,
            image TEXT,
            quantity INTEGER,
            price REAL
          )
        ''');
      },
    );
  }

    Future<void> insertItem(CartItem item) async {
      final db = await database;
      await db.insert(
        'cart',
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

  Future<void> updateItem(CartItem item) async {
    final db = await database;
    await db.update(
      'cart',
      item.toMap(),
      where: 'productId = ?',
      whereArgs: [item.productId],
    );
  }

  Future<void> deleteItem(int productId) async {
    final db = await database;
    await db.delete(
      'cart',
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  Future<List<CartItem>> getAllItems() async {
    final db = await database;
    final maps = await db.query('cart');
    return maps.map((e) => CartItem.fromMap(e)).toList();
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart');
  }
}
