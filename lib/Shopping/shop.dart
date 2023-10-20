import 'package:flutter/material.dart';
import 'package:groot/Shopping/CartDetail.dart';
import 'package:groot/Shopping/product_detail.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  // A list of products to display
  final List<Product> products = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Page'),
        actions: [
          GestureDetector(
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => CartPage()))),
            },
            child: Container(
              margin: EdgeInsets.only(
                right: 10,
              ),
              child: Icon(Icons.shopping_bag),
            ),
          ),
        ],
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
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // The number of items per row
          crossAxisSpacing: 8.0, // The horizontal spacing between items
          mainAxisSpacing: 8.0, // The vertical spacing between items
          childAspectRatio: 0.8, // The aspect ratio of each item
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          // Get the product at the current index
          final product = products[index];
          return Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            child: Card(
              child: InkWell(
                // Use InkWell to make the card clickable
                onTap: () {
                  // Navigate to the product details page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailsPage(product: product),
                    ),
                  );
                },
                child: Column(
                  // Use Column to arrange the widgets vertically
                  children: [
                    Expanded(
                      // Use Expanded to fill the remaining space
                      child: Image.asset(product.image),
                    ),
                    Padding(
                      // Use Padding to add some space around the text
                      padding: const EdgeInsets.all(8.0),
                      child: Text(product.name),
                    ),
                    Text('\$${product.price}'),
                  ],
                ),
              ),
            ),
          );
        },
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

// A widget to display the product details
