import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    for (var item in _items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void addItem(CartItem item) {
    // Check if same item with same options already exists
    int existingIndex = _items.indexWhere(
      (existingItem) =>
          existingItem.name == item.name &&
          existingItem.size == item.size &&
          existingItem.temperature == item.temperature &&
          existingItem.sugarLevel == item.sugarLevel &&
          existingItem.serviceType == item.serviceType,
    );

    if (existingIndex >= 0) {
      // Update quantity if item exists
      _items[existingIndex].quantity += item.quantity;
    } else {
      // Add new item
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void updateQuantity(int index, int quantity) {
    if (quantity <= 0) {
      removeItem(index);
    } else {
      _items[index].quantity = quantity;
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  // Increment quantity
  void incrementQuantity(int index) {
    _items[index].quantity++;
    notifyListeners();
  }

  // Decrement quantity
  void decrementQuantity(int index) {
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
      notifyListeners();
    } else {
      removeItem(index);
    }
  }
}
