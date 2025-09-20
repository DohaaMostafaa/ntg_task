import '../entities/cart_item.dart';

abstract class CartRepository {
  Future<List<CartItem>> getAllItems();

  Future<void> insertItem(CartItem item);

  Future<void> updateItem(CartItem item);

  Future<void> deleteItem(int productId);

  Future<void> clearCart();
}
