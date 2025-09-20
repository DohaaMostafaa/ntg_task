import 'package:flutter_test/flutter_test.dart';
import 'package:ntg_task/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ntg_task/features/cart/domain/entities/cart_item.dart';
import '../mocks/mock_local_database.dart';

void main() {
  late CartRepositoryImpl repository;
  late MockLocalDatabase mockDatabase;

  setUp(() {
    mockDatabase = MockLocalDatabase();
    repository = CartRepositoryImpl(mockDatabase);
  });

  tearDown(() {
    mockDatabase.reset();
  });

  group('CartRepository', () {
    final testItem = CartItem(
      productId: 1,
      title: 'Test Product',
      category: 'Test Category',
      image: 'test_image.jpg',
      price: 9.99,
    );

    test('getAllItems should return empty list initially', () async {
      final items = await repository.getAllItems();
      expect(items, isEmpty);
    });

    test('insertItem should add item to database', () async {
      await repository.insertItem(testItem);
      final items = await repository.getAllItems();
      expect(items.length, 1);
      expect(items.first.productId, testItem.productId);
    });

    test('updateItem should modify existing item', () async {
      await repository.insertItem(testItem);
      final updatedItem = CartItem(
        productId: testItem.productId,
        title: testItem.title,
        category: testItem.category,
        image: testItem.image,
        price: testItem.price,
        quantity: 2,
      );

      await repository.updateItem(updatedItem);
      final items = await repository.getAllItems();
      expect(items.first.quantity, 2);
    });

    test('deleteItem should remove item from database', () async {
      await repository.insertItem(testItem);
      await repository.deleteItem(testItem.productId);
      final items = await repository.getAllItems();
      expect(items, isEmpty);
    });

    test('clearCart should remove all items', () async {
      await repository.insertItem(testItem);
      await repository.insertItem(testItem.copyWith(productId: 2));
      await repository.clearCart();
      final items = await repository.getAllItems();
      expect(items, isEmpty);
    });
  });
}
