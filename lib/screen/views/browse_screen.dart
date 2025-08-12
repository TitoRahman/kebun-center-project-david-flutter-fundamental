import 'package:flutter/material.dart';
import 'package:flutter_project_food_delivery_david/screen/views/cart_checkout.dart';
import 'package:flutter_project_food_delivery_david/screen/views/food_detail/food_detail.dart';
import 'package:flutter_project_food_delivery_david/utils/db/database_helper.dart';
import 'package:flutter_project_food_delivery_david/model/food.dart';
import 'package:flutter_project_food_delivery_david/screen/components/food_card.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  List<Food> _foods = [];
  List<Food> _filteredFoods = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFoods();
  }

  Future<void> _loadFoods() async {
    final db = DatabaseHelper.instance;
    final foods = await db.getAllFoods();
    setState(() {
      _foods = foods;
      _filteredFoods = foods; // Initially, show all foods
      _isLoading = false;
    });
  }

  void _filterFoods(String query) {
    final filtered = _foods.where((food) {
      final nameLower = food.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();

    setState(() {
      _filteredFoods = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Browse',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartCheckout()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              leading: const Icon(Icons.search),
              elevation: const WidgetStatePropertyAll(0),
              backgroundColor: const WidgetStatePropertyAll(Colors.white),
              hintText: 'Search for food',
              onChanged: _filterFoods, // Call filter function
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredFoods.isEmpty
                    ? const Center(child: Text("No food found"))
                    : GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.9,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: _filteredFoods.length,
                        itemBuilder: (context, index) {
                          final food = _filteredFoods[index];
                          return FoodCard(
                            foodItem: food,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FoodDetail(food: food),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}