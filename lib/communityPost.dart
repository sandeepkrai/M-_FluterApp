import 'package:flutter/material.dart';
import 'package:groot/postdetail.dart';
import 'package:http/http.dart';

class CommunityForum extends StatefulWidget {
  const CommunityForum({Key? key}) : super(key: key);

  @override
  _CommunityForumState createState() => _CommunityForumState();
}

class _CommunityForumState extends State<CommunityForum> {
  List<Post> posts = [
    Post(
      author: 'Alice',
      title: 'My journey to lose 10 kg in 3 months',
      content:
          'I have been struggling with my weight for a long time, but I finally decided to take action and follow a healthy diet and exercise plan. Here is how I did it...',
      likes: 12,
      comments: [
        Comment(
          author: "Bob",
          authorImage:
              "https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/user/12.jpg",
          content: "Great job! Keep it up!",
        ),
        Comment(
          author: "Charlie",
          authorImage:
              "https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/user/12.jpg",
          content: "You are an inspiration!",
        ),
      ],
      authorImage:
          "https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/user/12.jpg",
      postImage:
          "https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/user/12.jpg",
    ),
    Post(
      author: 'Bob',
      title: 'How meditation changed my life',
      content:
          'I used to be stressed and anxious all the time, but then I discovered the benefits of meditation. It helped me calm my mind, improve my focus, and boost my mood. Here is how I started...',
      likes: 8,
      comments: [
        Comment(
          author: "Bob",
          authorImage:
              "https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/user/12.jpg",
          content: "Great job! Keep it up!",
        ),
        Comment(
          author: "Charlie",
          authorImage:
              "https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/user/12.jpg",
          content: "You are an inspiration!",
        ),
      ],
      authorImage:
          "https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/user/12.jpg",
      postImage:
          "https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/user/12.jpg",
    ),
    Post(
      author: 'Charlie',
      title: 'The best vegan recipes for beginners',
      content:
          'I have been vegan for a year now, and I love it. It is not only good for the animals and the environment, but also for my health and well-being. Here are some of the best vegan recipes that are easy and delicious...',
      likes: 15,
      comments: [
        Comment(
          author: "Bob",
          authorImage:
              "https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/user/12.jpg",
          content: "Great job! Keep it up!",
        ),
        Comment(
          author: "Charlie",
          authorImage:
              "https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/user/12.jpg",
          content: "You are an inspiration!",
        ),
      ],
      authorImage:
          "https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/user/12.jpg",
      postImage:
          "https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/user/12.jpg",
    ),
  ];

  // Function to handle the "like" button press
  void handleLikeButtonPress(int index) {
    setState(() {
      posts[index].likes++;
      // Increment the likes count for the post
    });
  }

  // Function to handle the "comment" button press
  void handleCommentButtonPress(int index) {
    // You can navigate to a new screen or show a dialog for adding comments here
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PostDetailPage(post: posts[index])));
  }

  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community Forum'),
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
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to the post detail page
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PostDetailPage(post: posts[index])));
            },
            child: Card(
              color: Color.fromARGB(255, 255, 255, 255),
              margin: EdgeInsets.all(10),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with author name and profile picture
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/user/12.jpg'),
                      ),
                      title: Text(
                        posts[index].author,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(Icons.more_vert),
                    ),
                    // Post image
                    Image.network(
                        'https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/user/12.jpg'),
                    // Icons for like, comment and share
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(Icons.favorite_border,
                              color: isLiked ? Colors.red : Colors.black),
                          onPressed: () {
                            if (isLiked == false) {
                              posts[index].addLike();
                            } else {
                              posts[index].likes--;
                            }
                            setState(() {
                              isLiked = !isLiked;
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.chat_bubble_outline),
                          onPressed: () {
                            handleCommentButtonPress(index);
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
                    // Number of likes
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        '${posts[index].likes} likes',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Post title and content
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: '${posts[index].author}: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: posts[index].title),
                            TextSpan(text: '\n'),
                            TextSpan(text: posts[index].content),
                          ],
                        ),
                      ),
                    ),
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

// Define a class for the comment object
class Comment {
  // Declare the fields for the comment object
  String author;
  String authorImage;
  String content;

  // Define a constructor that takes the fields as arguments
  Comment({
    required this.author,
    required this.authorImage,
    required this.content,
  });
}

class Post {
  // Declare the fields for the post object
  String author;
  String authorImage;
  String title;
  String content;
  String postImage;
  int likes;
  List<Comment> comments;

  // Define a constructor that takes the fields as arguments
  Post({
    required this.author,
    required this.authorImage,
    required this.title,
    required this.content,
    required this.postImage,
    required this.likes,
    required this.comments,
  });

  // Define a method to add a like to the post object
  void addLike() {
    // Increment the likes field by one
    likes++;
  }

  // Define a method to add a comment to the post object
  void addComment(String comment) {
    // Create a new comment object with some dummy data
    Comment newComment = Comment(
      author: 'User',
      authorImage: 'https://i.imgur.com/8jXl0Za.jpg',
      content: comment,
    );

    // Add the new comment object to the comments list
    comments.add(newComment);
  }
}
