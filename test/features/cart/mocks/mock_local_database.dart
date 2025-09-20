import 'package:ntg_task/features/cart/data/local/local_db.dart';
import 'package:ntg_task/features/cart/domain/entities/cart_item.dart';
import 'package:sqflite/sqflite.dart';

class MockLocalDatabase implements LocalDatabase {
  final Map<int, CartItem> _items = {};

  @override
  Future<Database> get database async => throw UnimplementedError('Database is not needed for tests');

  @override
  Future<List<CartItem>> getAllItems() async {
    return _items.values.toList();
  }

  @override
  Future<void> insertItem(CartItem item) async {
    _items[item.productId] = item;
  }

  @override
  Future<void> updateItem(CartItem item) async {
    _items[item.productId] = item;
  }

  @override
  Future<void> deleteItem(int productId) async {
    _items.remove(productId);
  }

  @override
  Future<void> clearCart() async {
    _items.clear();
  }

  // Helper method for testing
  void reset() {
    _items.clear();
  }
}
