class CartItem {
  final String id;
  final String name;
  final String category;
  final String image;
  final double price;
  final String size;
  final String temperature;
  final String sugarLevel;
  final String serviceType;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.price,
    required this.size,
    required this.temperature,
    required this.sugarLevel,
    required this.serviceType,
    this.quantity = 1,
  });

  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'image': image,
      'price': price,
      'size': size,
      'temperature': temperature,
      'sugarLevel': sugarLevel,
      'serviceType': serviceType,
      'quantity': quantity,
    };
  }

  // Create from Map
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      image: map['image'],
      price: map['price'],
      size: map['size'],
      temperature: map['temperature'],
      sugarLevel: map['sugarLevel'],
      serviceType: map['serviceType'],
      quantity: map['quantity'],
    );
  }
}
