import 'package:flutter/material.dart';
import 'package:flutter_project_food_delivery_david/model/food.dart';

// This is the detail screen for a single food item.
class FoodDetail extends StatefulWidget {
  final Food food;

  // Constructor receives a Food object to display its details
  const FoodDetail({super.key, required this.food});
  
  @override
  State<FoodDetail> createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  int quantity = 0; // Track the quantity of items user wants to order
  // final Food food = Food(
  //   id: "1",
  //   name: 'Pizza Margherita',
  //   description: 'Classic pizza with fresh mozzarella, tomatoes, and basil.',
  //   price: 12.99,
  //   imageUrl: 'https://example.com/pizza.jpg',
  // );
  // Function to increase or decrease quantity
  void handleQuantityChange(int change) {
    setState(() {
      quantity += change;
      if (quantity < 0) quantity = 0; // Prevent negative quantity
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar showing food name
      appBar: AppBar(
        title: Text(widget.food.name),
        backgroundColor: Colors.orange,
      ),

      // Body with all the food details
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Food image (from network URL)
            Image.network(
              widget.food.imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image, size: 100),
              ),
            ),

            const SizedBox(height: 16),

            // Food name and price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.food.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${widget.food.price.toStringAsFixed(0)}', // Display price with no decimals
                    style: const TextStyle(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Food description text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                widget.food.description,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),

            const SizedBox(height: 30),

            // Quantity selector (add/remove buttons)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Decrease button
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.orange,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.remove),
                      color: Colors.white,
                      onPressed: () => handleQuantityChange(-1),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Display current quantity
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "${widget.food.qty + quantity}",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Increase button
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.orange,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                      onPressed: () => handleQuantityChange(1),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // "Add to Cart" button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Add the food item and quantity to the cart
                    // For now, show a confirmation message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added to cart ${widget.food.name} ${widget.food.qty} item(s)')),
                    );
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}