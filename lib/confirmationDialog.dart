// Import the required packages
import 'package:flutter/material.dart';

// Define a function to show the confirmation dialog
bool showConfirmationDialog(BuildContext context) {
  bool isConfirmed = false;
  // Use the showDialog function to display the dialog
  showDialog(
    // Pass the context as an argument
    context: context,
    // Set the builder property to return an AlertDialog widget
    builder: (context) {
      return AlertDialog(
        // Set the title of the dialog
        title: Text('Do you want to avoid seeing this type of items?'),

        // Set the actions of the dialog
        actions: [
          // Display a TextButton widget for cancel option
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              // Pop the dialog from the navigation stack
              isConfirmed = true;
              Navigator.pop(context);
            },
          ),
          // Display a TextButton widget for confirm option
          TextButton(
            child: Text('No'),
            onPressed: () {
              // Perform the desired action here
              // Pop the dialog from the navigation stack
              isConfirmed = false;
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
  return isConfirmed;
}
