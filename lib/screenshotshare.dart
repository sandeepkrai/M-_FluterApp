// import 'package:flutter/material.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:share/share.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Screenshot Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // Create a screenshot controller
//   ScreenshotController screenshotController = ScreenshotController();

//   // A variable to store the captured image
//   Uint8List? _imageFile;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Screenshot Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Wrap the widget you want to capture in a Screenshot widget
//             Screenshot(
//               controller: screenshotController,
//               child: Container(
//                 color: Colors.red,
//                 padding: EdgeInsets.all(20),
//                 child: Text(
//                   'Hello, world!',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             // Display the captured image if it is not null
//             _imageFile != null ? Image.memory(_imageFile!) : Container(),
//             SizedBox(height: 20),
//             // A button to capture the widget as an image
//             ElevatedButton(
//               onPressed: () async {
//                 // Capture the widget and store it in _imageFile
//                 _imageFile = null;
//                 setState(() {});
//                 _imageFile = await screenshotController.capture();
//                 setState(() {});
//               },
//               child: Text('Capture'),
//             ),
//             SizedBox(height: 10),
//             // A button to save the captured image to the device storage
//             ElevatedButton(
//               onPressed: () async {
//                 // Save the image to the device storage using image_gallery_saver package
//                 final result = await ImageGallerySaver.saveImage(_imageFile!);
//                 print(result);
//               },
//               child: Text('Save'),
//             ),
//             SizedBox(height: 10),
//             // A button to share the captured image with other apps
//             ElevatedButton(
//               onPressed: () async {
//                 // Share the image using share package
//                 Share.shareFiles(['${_imageFile!.path}']);
//               },
//               child: Text('Share'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
