import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/usecases/cart_usecases.dart';
import 'states.dart';

class CartCubit extends Cubit<CartState> {
  final GetAllCartItems getAllCartItemsUseCase;
  final AddCartItem addCartItemUseCase;
  final UpdateCartItem updateCartItemUseCase;
  final DeleteCartItem deleteCartItemUseCase;
  final ClearCart clearCartUseCase;

  final Map<int, CartItem> _cartItems = {};

  CartCubit(
      this.getAllCartItemsUseCase,
      this.addCartItemUseCase,
      this.updateCartItemUseCase,
      this.deleteCartItemUseCase,
      this.clearCartUseCase,
      ) : super(CartInitial());

  static CartCubit get(context) => BlocProvider.of(context);

  Map<int, CartItem> get items => _cartItems;
  bool isInCart(int productId) => _cartItems.containsKey(productId);
  int getQuantity(int productId) => _cartItems[productId]?.quantity ?? 0;
  int get totalQuantity =>
      _cartItems.values.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice =>
      _cartItems.values.fold(0, (sum, item) => sum + (item.price * item.quantity));
  List<CartItem> get cartItemsList => _cartItems.values.toList();

  Future<void> init() async => loadCartFromDB();

  Future<void> loadCartFromDB() async {
    emit(CartLoading());
    try {
      final list = await getAllCartItemsUseCase();
      _cartItems
        ..clear()
        ..addEntries(list.map((e) => MapEntry(e.productId, e)));
      emit(CartUpdated());
    } catch (e) {
      emit(CartError("Failed to load cart"));
    }
  }

  Future<void> addItem(CartItem item) async {
    final existingItem = _cartItems[item.productId];
    final updatedItem = existingItem != null
        ? existingItem.copyWith(quantity: existingItem.quantity + 1)
        : item;

    _cartItems[item.productId] = updatedItem;

    try {
      if (existingItem != null) {
        await updateCartItemUseCase(updatedItem);
      } else {
        await addCartItemUseCase(item);
      }
      emit(CartUpdated());
    } catch (e) {
      emit(CartError("Failed to add item"));
    }
  }

  Future<void> removeItem(int productId) async {
    final existingItem = _cartItems[productId];
    if (existingItem == null) return;

    final updatedQuantity = existingItem.quantity - 1;

    try {
      if (updatedQuantity > 0) {
        final updatedItem = existingItem.copyWith(quantity: updatedQuantity);
        _cartItems[productId] = updatedItem;
        await updateCartItemUseCase(updatedItem);
      } else {
        _cartItems.remove(productId);
        await deleteCartItemUseCase(productId);
      }
      emit(CartUpdated());
    } catch (e) {
      emit(CartError("Failed to remove item"));
    }
  }

  Future<void> deleteItem(int productId) async {
    if (!_cartItems.containsKey(productId)) return;

    _cartItems.remove(productId);

    try {
      await deleteCartItemUseCase(productId);
      emit(CartUpdated());
    } catch (e) {
      emit(CartError("Failed to delete item"));
    }
  }

  Future<void> clearCart() async {
    _cartItems.clear();
    try {
      await clearCartUseCase();
      emit(CartUpdated());
    } catch (e) {
      emit(CartError("Failed to clear cart"));
    }
  }
}
