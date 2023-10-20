import 'package:flutter/material.dart';

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
      comments: 3,
    ),
    Post(
      author: 'Bob',
      title: 'How meditation changed my life',
      content:
          'I used to be stressed and anxious all the time, but then I discovered the benefits of meditation. It helped me calm my mind, improve my focus, and boost my mood. Here is how I started...',
      likes: 8,
      comments: 2,
    ),
    Post(
      author: 'Charlie',
      title: 'The best vegan recipes for beginners',
      content:
          'I have been vegan for a year now, and I love it. It is not only good for the animals and the environment, but also for my health and well-being. Here are some of the best vegan recipes that are easy and delicious...',
      likes: 15,
      comments: 4,
    ),
  ];

  // Function to handle the "like" button press
  void handleLikeButtonPress(int index) {
    setState(() {
      posts[index].likes++; // Increment the likes count for the post
    });
  }

  // Function to handle the "comment" button press
  void handleCommentButtonPress(int index) {
    // You can navigate to a new screen or show a dialog for adding comments here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community Forum'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${posts[index].author}: ${posts[index].title}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    posts[index].content,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // "Like" button
                      IconButton(
                        icon: Icon(Icons.thumb_up),
                        onPressed: () {
                          handleLikeButtonPress(index);
                        },
                      ),
                      Text('${posts[index].likes}'),
                      SizedBox(width: 10),
                      // "Comment" button
                      IconButton(
                        icon: Icon(Icons.comment),
                        onPressed: () {
                          handleCommentButtonPress(index);
                        },
                      ),
                      Text('${posts[index].comments}'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Post {
  final String author;
  final String title;
  final String content;
  int likes;
  final int comments;

  Post({
    required this.author,
    required this.title,
    required this.content,
    required this.likes,
    required this.comments,
  });
}