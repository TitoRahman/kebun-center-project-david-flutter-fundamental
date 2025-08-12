import 'package:flutter/material.dart';
import 'package:flutter_project_food_delivery_david/model/food.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({
    super.key,
    required this.foodItem,
    required this.onTap,
  });

  final Food foodItem;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
        children: [
          Image.network(
            foodItem.imageUrl,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.broken_image);
            },
            
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(foodItem.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Text('\$${foodItem.price.toStringAsFixed(2)}'),
              ],
            ),
          ),
        ],
      ),
    )
    );
  }
}