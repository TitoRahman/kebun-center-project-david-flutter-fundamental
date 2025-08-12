
import 'package:flutter/material.dart';
import 'package:flutter_project_food_delivery_david/screen/components/bottom_navigation.dart';
import 'package:flutter_project_food_delivery_david/screen/views/browse_screen.dart';
import 'package:flutter_project_food_delivery_david/screen/views/cart_checkout.dart';
import 'package:flutter_project_food_delivery_david/screen/views/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;
  final List<Widget> _pages = [
    const BrowseScreen(), // 0
    const ProfileScreen(),
  ];
  String toUpperCase(String text) {
    _currentIndex += 1;
    return text.toUpperCase();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    // return CartCheckout();
    return Scaffold(
      body: _pages[_currentIndex], // _pages[0]
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}