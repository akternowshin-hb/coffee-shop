import 'package:flutter/material.dart';

class CoffeeDetailScreen extends StatefulWidget {
  final Map<String, dynamic> coffeeData;

  const CoffeeDetailScreen({super.key, required this.coffeeData});

  @override
  State<CoffeeDetailScreen> createState() => _CoffeeDetailScreenState();
}

class _CoffeeDetailScreenState extends State<CoffeeDetailScreen> {
  int selectedSizeIndex = 1;
  int selectedTempIndex = 1;
  int selectedSugarIndex = 1;
  int selectedServiceIndex = 1;
  int selectedQuantityIndex = 0; // Missing variable added
  int quantity = 1;
  bool isFavorite = false;
  bool isDescriptionExpanded = false;

  double get totalPrice {
    double basePrice = widget.coffeeData['price']?.toDouble() ?? 4.53;
    // Size multiplier
    double sizeMultiplier = selectedSizeIndex == 0
        ? 0.8
        : (selectedSizeIndex == 1 ? 1.0 : 1.2);
    return basePrice * sizeMultiplier * quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Stack(
              children: [
                // Coffee Image
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image.asset(
                      widget.coffeeData['image'] ?? 'assets/images/coffee4.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFF3A3A3A),
                          child: const Icon(
                            Icons.local_cafe,
                            size: 100,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // App bar
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A1A),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        const Text(
                          'Details',
                          style: TextStyle(
                            color: Color(0xFF1A1A1A),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1A1A1A),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom Section with Details
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.coffeeData['name'] ?? 'Cappuccino',
                                style: const TextStyle(
                                  color: Color(0xFF1A1A1A),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.coffeeData['category'] ?? 'Ice/Hot',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            buildIconButton(
                              Icons.delivery_dining,
                              const Color(0xFFC67C4E),
                            ),
                            const SizedBox(width: 8),
                            buildIconButton(
                              Icons.coffee,
                              const Color(0xFFC67C4E),
                            ),
                            const SizedBox(width: 8),
                            buildIconButton(
                              Icons.local_cafe,
                              const Color(0xFFC67C4E),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Rating
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFBBE21),
                          size: 24,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          (widget.coffeeData['rating'] ?? 4.8).toString(),
                          style: const TextStyle(
                            color: Color(0xFF1A1A1A),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${widget.coffeeData['reviews'] ?? '200+'} Reviews)',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: Color(0xFFE3E3E3)),
                    const SizedBox(height: 16),

                    // Description
                    const Text(
                      'Description',
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isDescriptionExpanded
                              ? (widget.coffeeData['description'] ??
                                    'A cappuccino is an espresso-based coffee drink that originated in Italy, and is traditionally prepared with steamed milk foam. Variations of the drink involve the use of cream instead of milk, and flavoring with cinnamon or chocolate powder.')
                              : _getShortDescription(
                                  widget.coffeeData['description'] ??
                                      'A cappuccino is an espresso-based coffee drink that originated in Italy...',
                                ),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isDescriptionExpanded = !isDescriptionExpanded;
                            });
                          },
                          child: Text(
                            isDescriptionExpanded ? 'Show Less' : 'Read More',
                            style: const TextStyle(
                              color: Color(0xFFC67C4E),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Drink size
                    const Text(
                      'Size',
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(child: _buildSizeOption('S', 0)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildSizeOption('M', 1)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildSizeOption('L', 2)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Temperature
                    const Text(
                      'Temperature',
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildOptionButton(
                            'Hot',
                            0,
                            selectedTempIndex,
                            (index) {
                              setState(() {
                                selectedTempIndex = index;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildOptionButton(
                            'Ice',
                            1,
                            selectedTempIndex,
                            (index) {
                              setState(() {
                                selectedTempIndex = index;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Sugar level
                    const Text(
                      'Sugar Level',
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildOptionButton(
                            'Normal',
                            0,
                            selectedSugarIndex,
                            (index) {
                              setState(() {
                                selectedSugarIndex = index;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildOptionButton(
                            '50% Less',
                            1,
                            selectedSugarIndex,
                            (index) {
                              setState(() {
                                selectedSugarIndex = index;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildOptionButton(
                            'No Sugar',
                            2,
                            selectedSugarIndex,
                            (index) {
                              setState(() {
                                selectedSugarIndex = index;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Service type
                    const Text(
                      'Service Type',
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildOptionButton(
                            'Dine In',
                            0,
                            selectedServiceIndex,
                            (index) {
                              setState(() {
                                selectedServiceIndex = index;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildOptionButton(
                            'Take Away',
                            1,
                            selectedServiceIndex,
                            (index) {
                              setState(() {
                                selectedServiceIndex = index;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Quantity
                    const Text(
                      'Quantity',
                      style: TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                              });
                            }
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFE3E3E3),
                                width: 1.5,
                              ),
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              quantity.toString(),
                              style: const TextStyle(
                                color: Color(0xFF1A1A1A),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              quantity++;
                            });
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFE3E3E3),
                                width: 1.5,
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100), // Extra space for bottom bar
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Price Section
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Price',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$ ${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Color(0xFFC67C4E),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              // Add to Cart Button
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Add to cart functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${widget.coffeeData['name']} added to cart!',
                        ),
                        duration: const Duration(seconds: 2),
                        backgroundColor: const Color(0xFFC67C4E),
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC67C4E),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIconButton(IconData icon, Color color) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }

  Widget _buildSizeOption(String size, int index) {
    final isSelected = selectedSizeIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSizeIndex = index;
        });
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF5EE) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFC67C4E)
                : const Color(0xFFE3E3E3),
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xFFC67C4E)
                  : const Color(0xFF1A1A1A),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(
    String label,
    int index,
    int selectedIndex,
    Function(int) onTap,
  ) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF5EE) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFC67C4E)
                : const Color(0xFFE3E3E3),
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xFFC67C4E)
                  : const Color(0xFF1A1A1A),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  String _getShortDescription(String description) {
    if (description.length > 80) {
      return '${description.substring(0, 80)}...';
    }
    return description;
  }
}
