import 'package:flutter_project_food_delivery_david/model/cart_item.dart';

class Cart {
  List<CartItem> items;

  Cart({
    this.items = const [],
  });

void addItem(CartItem item) {
  final index = items.indexWhere((i) => i.id == item.id);
  if (index != -1) {
    items[index].quantity += item.quantity;
  } else {
    items.add(item);
  }
}

  void removeItem(String itemId) {
    final index = items.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      items.removeAt(index);
    }
  }

  double get totalPrice =>
    items.fold(0.0, (sum, item) => sum + item.price * item.quantity);

  int get totalQuantity =>
      items.fold(0, (sum, item) => sum + item.quantity);

  void clear() {
    items.clear();
  }
  
}