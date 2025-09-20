import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class GetAllCartItems {
  final CartRepository repository;

  GetAllCartItems(this.repository);

  Future<List<CartItem>> call() async {
    return await repository.getAllItems();
  }
}

class AddCartItem {
  final CartRepository repository;

  AddCartItem(this.repository);

  Future<void> call(CartItem item) async {
    await repository.insertItem(item);
  }
}

class UpdateCartItem {
  final CartRepository repository;

  UpdateCartItem(this.repository);

  Future<void> call(CartItem item) async {
    await repository.updateItem(item);
  }
}

class DeleteCartItem {
  final CartRepository repository;

  DeleteCartItem(this.repository);

  Future<void> call(int productId) async {
    await repository.deleteItem(productId);
  }
}

class ClearCart {
  final CartRepository repository;

  ClearCart(this.repository);

  Future<void> call() async {
    await repository.clearCart();
  }
}
