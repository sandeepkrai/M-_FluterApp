import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:groot/Shopping/CartDetail.dart';
import 'package:groot/Shopping/product_detail.dart';
import 'package:groot/confirmationDialog.dart';

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
      rating: 5,
      reviews: 10,
    ),
    Product(
      name: 'MacBook Pro',
      price: 1999.00,
      image: 'assets/images/2.png',
      description:
          'The ultimate laptop for professionals and creatives with a powerful processor and graphics.',
      rating: 5,
      reviews: 10,
    ),
    Product(
      name: 'AirPods Pro',
      price: 249.00,
      image: 'assets/images/3.png',
      description:
          'The best wireless earbuds from Apple with active noise cancellation and spatial audio.',
      rating: 5,
      reviews: 10,
    ),
  ];
  // handle thubs down by removing that index item from products
  void handleLikeButtonPress(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

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
                      Text('₹${product.price}'),
                      // Display a row with rating stars and number of reviews
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Use a for loop to create the rating stars
                          for (int i = 0; i < product.rating; i++)
                            Icon(Icons.star, color: Colors.yellow),
                          // Use a SizedBox to add some space between the stars and the number of reviews
                          SizedBox(width: 10),
                          Text('(${product.reviews})'),
                        ],
                      ),
                      // Display a row with like and dislike buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.thumb_up),
                            onPressed: () {
                              handleLikeButtonPress(index);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.thumb_down),
                            onPressed: () {
                              // handleDislikeButtonPress(index);
                              showConfirmationDialog(context)
                                  ? setState(() => {
                                        products.removeAt(index),
                                      })
                                  : print("no");
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}

// A class to represent a product
// Define a class for the product object
class Product {
  // Declare the fields for the product object
  String name;
  String image;
  double price;
  int rating;
  int reviews;
  String description;

  // Define a constructor that takes the fields as arguments
  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.description,
  });
}


// A widget to display the product details
