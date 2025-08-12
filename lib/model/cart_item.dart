class CartItem {
  final String id;
  final String foodId;
  int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.foodId,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'foodId': foodId,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      foodId: map['foodId'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }
}