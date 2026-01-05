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
  int quantity = 1;
  bool isFavorite = false;
  bool isDescriptionExpanded = false;

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
                // coffee Image
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Image.asset(
                      widget.coffeeData['image'] ?? 'assets/images/coffee4.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, StackTrace) {
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
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                            color: Color (0xFF1A1A1A),
                            borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                              size: 20,
                            )
                          ),
                        ),
                        const Text(
                          'Details',
                          style: TextStyle(
                            color: Color (0xFF1A1A1A),
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
                            color: Color (0xFF1A1A1A),
                            borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              isFavorite ? Icons.favorite :  Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.white,
                              size: 24,
                            )
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ], 
            ),
          ),
        ],
      ),
    );
  }
}
