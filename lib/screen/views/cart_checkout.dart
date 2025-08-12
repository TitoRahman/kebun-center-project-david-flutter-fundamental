import 'package:flutter/material.dart';
import 'package:flutter_project_food_delivery_david/model/food.dart';

class CartCheckout extends StatefulWidget {
  const CartCheckout({super.key});

  @override
  State<CartCheckout> createState() => _CartCheckoutState();
}

class _CartCheckoutState extends State<CartCheckout> {
  final List<Food> cartItems = [
    Food(
      name: 'Pizza',
      price: 10.99,
      id: "1",
      qty: 10,
      description: "Delicious cheese pizza",
      imageUrl:
          "https://assets.tmecosys.com/image/upload/t_web_rdp_recipe_584x480_1_5x/img/recipe/ras/Assets/658A0A74-039A-487C-A07A-CAAF61B4615D/Derivates/A230DF28-60DF-429D-ABDA-96ED64E9EE10.jpg",
    ),
    Food(
      name: 'Burger',
      price: 8.99,
      id: "2",
      qty: 2,
      description: "Juicy beef burger",
      imageUrl:
          "https://assets.tmecosys.com/image/upload/t_web_rdp_recipe_584x480_1_5x/img/recipe/ras/Assets/658A0A74-039A-487C-A07A-CAAF61B4615D/Derivates/A230DF28-60DF-429D-ABDA-96ED64E9EE10.jpg",
    ),
    Food(
      name: 'Pasta',
      price: 12.99,
      id: "3",
      qty: 3,
      description: "Creamy Alfredo pasta",
      imageUrl:
          "https://assets.tmecosys.com/image/upload/t_web_rdp_recipe_584x480_1_5x/img/recipe/ras/Assets/658A0A74-039A-487C-A07A-CAAF61B4615D/Derivates/A230DF28-60DF-429D-ABDA-96ED64E9EE10.jpg",
    ),
  ];

  String? selectedPayment;

  double get subtotal =>
      cartItems.fold(0, (sum, item) => sum + item.price * item.qty);
  double get tax => subtotal * 0.11;
  double get adminFee => subtotal * 0.05;
  double get shipmentFee => 5.0;
  double get total => subtotal + tax + adminFee + shipmentFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSectionTitle("Order Summary"),
            Divider(),
            _buildCartList(),
            const Divider(),
            _buildPriceRow("Subtotal", subtotal),
            _buildPriceRow("Tax (11%)", tax),
            _buildPriceRow("Admin Fee (5%)", adminFee),
            _buildPriceRow("Shipment Fee", shipmentFee),
            const SizedBox(height: 16),
            _buildNotice(
                "Be sure to double check your order before confirming!"),
            const Divider(),
            _buildLocationRow(),
            const Divider(),
            _buildPaymentRow(),
            const Divider(),
            _buildCouponRow(),
            const Divider(),
            _buildPriceRow("Total", total, isBold: true),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.orange),
                ),
                onPressed: () {
                  // Handle checkout logic
                },
                child: const Text(
                  "Order Now",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return SizedBox(
      width: double.infinity,
      child: Text(title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildCartList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              ClipOval(
                child: Image.network(
                  item.imageUrl,
                  height: 75,
                  width: 75,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(item.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("\$${item.price.toStringAsFixed(2)}"),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(99.0),
                      border: Border.all(color: Colors.orange, width: 1.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    width: 36,
                    height: 36,
                    child: Text("${item.qty}"),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCouponRow() {
    return Row(
      children: [
        Icon(Icons.local_offer, color: Colors.blue[400], size: 32),
        const SizedBox(width: 16),
        Expanded(
          child: TextField(
            
            decoration: InputDecoration(
              focusColor: Colors.orange,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.orange, width: 1),
              ),
              hintText: "Enter coupon code",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.orange, width: 1),
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildPriceRow(String label, double value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Text("\$${value.toStringAsFixed(2)}",
            style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  Widget _buildNotice(String message) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        message,
        style: TextStyle(
            color: Colors.grey[600], fontStyle: FontStyle.italic, fontSize: 14),
      ),
    );
  }

  Widget _buildLocationRow() {
    return Row(
      children: [
        Icon(Icons.location_on, color: Colors.red[400], size: 32),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Location", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text("Set Your Location",
                style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentRow() {
    return Row(
      children: [
        Icon(Icons.credit_card, color: Colors.green[400], size: 32),
        const SizedBox(width: 16),
        Expanded(
          child: DropdownButton<String>(
            value: selectedPayment,
            hint: const Text("Select Payment Method"),
            isExpanded: true,
            items: const [
              DropdownMenuItem(
                  value: "credit_card", child: Text("Credit Card", style: TextStyle(fontSize: 16))),
              DropdownMenuItem(value: "cash", child: Text("Cash on Delivery", style: TextStyle(fontSize: 16))),
              DropdownMenuItem(value: "paypal", child: Text("PayPal", style: TextStyle(fontSize: 16))),
            ],
            onChanged: (value) {
              setState(() {
                selectedPayment = value;
              });
            },
          ),
        ),
      ],
    );
  }
}