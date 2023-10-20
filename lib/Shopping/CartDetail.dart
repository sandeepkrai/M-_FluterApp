import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // A list of products in the cart
  final List<Product> cart = [
    Product(
      name: 'iPhone 13',
      price: 799.00,
      image: 'assets/images/1.png',
      description:
          'The latest smartphone from Apple with a stunning design and performance.',
    ),
    Product(
      name: 'MacBook Pro',
      price: 1999.00,
      image: 'assets/images/2.png',
      description:
          'The ultimate laptop for professionals and creatives with a powerful processor and graphics.',
    ),
    Product(
      name: 'AirPods Pro',
      price: 249.00,
      image: 'assets/images/3.png',
      description:
          'The best wireless earbuds from Apple with active noise cancellation and spatial audio.',
    ),
  ];

  // A variable to store the total amount of the cart
  double total = 0.0;

  @override
  void initState() {
    super.initState();
    // Calculate the total amount of the cart by adding the prices of all products
    total = cart.fold(0.0, (sum, product) => sum + product.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 199, 219, 211),
                Color.fromARGB(255, 147, 228, 198),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                // Get the product at the current index
                final product = cart[index];
                return Dismissible(
                  // Use Dismissible to allow swiping to remove an item from the cart
                  key: Key(product.name), // Use a unique key for each item
                  direction: DismissDirection
                      .endToStart, // Only allow swiping from right to left
                  onDismissed: (direction) {
                    // Remove the product from the cart
                    setState(() {
                      cart.removeAt(index);
                      // Update the total amount of the cart
                      total -= product.price;
                    });
                  },
                  background: Container(
                    // Use a red container with an icon and a text as the background of the Dismissible
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .end, // Align the icon and the text to the end of the row
                      children: [
                        Icon(Icons.delete, color: Colors.white),
                        Text('Remove', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  child: Card(
                    child: ListTile(
                      leading: Image.asset(product.image),
                      title: Text(product.name),
                      subtitle: Text('\$${product.price}'),
                      trailing: Icon(Icons
                          .remove_circle), // Use an icon to indicate that the item can be removed
                      onTap:
                          () {}, // TODO: Implement the logic for viewing or editing the product details
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            // Use Padding to add some space around the text and the button
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Total Amount: \$${total.toStringAsFixed(2)}', // Use toStringAsFixed(2) to format the total amount with two decimal places
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                GestureDetector(
                  // Use ElevatedButton for a raised button with a primary color
                  onTap:
                      () {}, // TODO: Implement the logic for checking out the cart
                  child: Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 199, 219, 211),
                            Color.fromARGB(255, 147, 228, 198),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )), // Use Text to display the button label
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// A class to represent a product
class Product {
  final String name;
  final double price;
  final String image;
  final String description;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });
}
