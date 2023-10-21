// Import the required packages
import 'package:flutter/material.dart';
import 'package:groot/communityPost.dart';

// Define a stateful widget for the detail page
class PostDetailPage extends StatefulWidget {
  // Declare a final variable to store the post object
  final Post post;

  // Define a constructor that takes the post object as an argument
  PostDetailPage({required this.post});

  // Override the createState method to return a new instance of _PostDetailPageState
  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

// Define a state class for the detail page
class _PostDetailPageState extends State<PostDetailPage> {
  // Declare a TextEditingController to handle the comment input
  TextEditingController _commentController = TextEditingController();

  // Declare a method to handle the submit button press
  void handleSubmitButtonPress() {
    // Get the comment text from the controller
    String comment = _commentController.text;

    // Validate the comment text
    if (comment.isNotEmpty) {
      // Add the comment to the post object
      widget.post.addComment(comment);

      // Clear the controller text
      _commentController.clear();

      // Update the state of the widget
      setState(() {});
    }
  }

  bool isLiked = false;

  // Override the build method to return a Scaffold widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the app bar with the post title
      appBar: AppBar(
        title: Text(widget.post.title),
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
      // Set the body with a SingleChildScrollView widget
      body: SingleChildScrollView(
        // Set the child with a Column widget
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the post image
            Image.network(widget.post.postImage),
            // Display the post content with padding
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                widget.post.content,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  color: isLiked ? Colors.red : Colors.black,
                  onPressed: () {
                    // handleLikeButtonPress(index);
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // handleShareButtonPress(index);
                  },
                ),
              ],
            ),
            // Display a horizontal divider
            Divider(),
            // Display the number of comments with padding
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                '${widget.post.comments.length} comments',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Display a ListView.builder widget to show the comments
            ListView.builder(
              // Set the shrinkWrap property to true to avoid overflow error
              shrinkWrap: true,
              // Set the physics property to NeverScrollableScrollPhysics to disable scrolling
              physics: NeverScrollableScrollPhysics(),
              // Set the itemCount to the length of the comments list
              itemCount: widget.post.comments.length,
              // Set the itemBuilder to return a ListTile widget for each comment
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.post.comments[index].authorImage),
                  ),
                  title: Text(widget.post.comments[index].author),
                  subtitle: Text(widget.post.comments[index].content),
                );
              },
            ),
          ],
        ),
      ),
      // Set the bottom navigation bar with a Row widget
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Row(
          children: [
            // Display an Expanded widget with a TextField widget for comment input
            Expanded(
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'Write a comment...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            // Display an IconButton widget for submit button
            IconButton(
              icon: Icon(Icons.send),
              onPressed: handleSubmitButtonPress,
            ),
          ],
        ),
      ),
    );
  }
}
