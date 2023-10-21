// Import the required packages
import 'package:flutter/material.dart';

// Define a stateful widget for the achievements page
class AchievementsPage extends StatefulWidget {
  // Override the createState method to return a new instance of _AchievementsPageState
  @override
  _AchievementsPageState createState() => _AchievementsPageState();
}

// Define a state class for the achievements page
class _AchievementsPageState extends State<AchievementsPage> {
  // Declare a list of badge objects to store the achievements data
  List<Badge> badges = [
    Badge(title: 'Newbie', image: "assets/images/img_coin.png"),
    Badge(title: 'Active', image: "assets/images/img_coin.png"),
    Badge(title: 'Popular', image: "assets/images/img_coin.png"),
    Badge(title: 'Influencer', image: "assets/images/img_coin.png"),
    Badge(title: 'Expert', image: "assets/images/img_coin.png"),
    Badge(title: 'Master', image: "assets/images/img_coin.png"),
  ];

  // Override the build method to return a Scaffold widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the app bar with the page title
      appBar: AppBar(
        title: Text('Your Achievements'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 28, 77, 59),
                Color.fromARGB(255, 147, 228, 198),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      // Set the body with a GridView.builder widget
      body: GridView.builder(
        // Set the gridDelegate property to control the layout of the grid
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // Set the crossAxisCount to 2 to display two items per row
          crossAxisCount: 2,
          // Set the crossAxisSpacing and mainAxisSpacing to 10 to add some space between the items
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        // Set the padding property to EdgeInsets.all(10) to add some space around the grid
        padding: EdgeInsets.all(10),
        // Set the itemCount to the length of the badges list
        itemCount: badges.length,
        // Set the itemBuilder to return a Card widget for each badge
        itemBuilder: (context, index) {
          return Card(
            // Set the child with a Column widget
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display the badge image with an Image.network widget
                Image.asset(badges[index].image),
                // Display the badge title with a Text widget
                Text(
                  badges[index].title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Define a class for the badge object
class Badge {
  // Declare the fields for the badge object
  String title;
  String image;

  // Define a constructor that takes the fields as arguments
  Badge({
    required this.title,
    required this.image,
  });
}
