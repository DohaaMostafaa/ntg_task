class CartItem {
  final int productId;
  final String title;
  final String category;
  final String image;
  int quantity;
  final double price;

  CartItem({
    required this.productId,
    required this.title,
    required this.category,
    required this.image,
    this.quantity = 1,
    required this.price,
  });

  CartItem copyWith({
    int? productId,
    String? title,
    String? category,
    String? image,
    int? quantity,
    double? price,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      category: category ?? this.category,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'category': category,
      'image': image,
      'quantity': quantity,
      'price': price,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      productId: map['productId'] as int,
      title: map['title'] as String,
      category: map['category'] as String,
      image: map['image'] as String,
      quantity: map['quantity'] as int? ?? 1,
      price: map['price'] is int
          ? (map['price'] as int).toDouble()
          : map['price'] as double,
    );
  }
}
