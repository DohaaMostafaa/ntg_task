import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../local/local_db.dart';

class CartRepositoryImpl implements CartRepository {
  final LocalDatabase _db;

  CartRepositoryImpl(this._db);

  @override
  Future<List<CartItem>> getAllItems() => _db.getAllItems();

  @override
  Future<void> insertItem(CartItem item) => _db.insertItem(item);

  @override
  Future<void> updateItem(CartItem item) => _db.updateItem(item);

  @override
  Future<void> deleteItem(int productId) => _db.deleteItem(productId);

  @override
  Future<void> clearCart() => _db.clearCart();
}
