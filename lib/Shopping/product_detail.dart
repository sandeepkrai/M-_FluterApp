import 'package:flutter/material.dart';
import 'package:groot/Shopping/CartDetail.dart' as cartdetail;
import 'package:groot/Shopping/CartDetail.dart';
import 'package:groot/Shopping/CartItems.dart';
import 'package:groot/Shopping/shop.dart' as shop;

class ProductDetailsPage extends StatelessWidget {
  final shop.Product product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(product.image),
            ),
            SizedBox(height: 16.0),
            Text(
              product.name,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '\$${product.price}',
              style: TextStyle(fontSize: 20.0, color: Colors.green),
            ),
            SizedBox(height: 16.0),
            Text(
              product.description,
              style: TextStyle(fontSize: 18.0),
            ),
            Spacer(), // Use Spacer to push the buttons to the bottom
            Row(
              // Use Row to arrange the buttons horizontally
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // Use spaceEvenly to distribute the space evenly between the buttons
              children: [
                GestureDetector(
                  // Use ElevatedButton for another raised button with a primary color
                  onTap:
                      () {}, // TODO: Implement the logic for adding the product to the cart
                  child: Container(
                    height: 40,
                    width: 80,
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
                    child: Center(child: Text('Buy Now')),
                  ), // Use Text to display the button label
                ),
                GestureDetector(
                  // Use ElevatedButton for another raised button with a primary color
                  onTap: () {
                    addProduct(product);
                  }, // TODO: Implement the logic for adding the product to the cart
                  child: Container(
                    height: 40,
                    width: 80,
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
                    child: Center(child: Text('Add to Cart')),
                  ), // Use Text to display the button label
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
