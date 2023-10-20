import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppBarMain extends StatelessWidget {
  const AppBarMain({Key? key, required this.user}) : super(key: key);
  final Map<String, dynamic> user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            child: ClipOval(
              child: Image.network(
                'https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/user/12.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Color.fromARGB(255, 28, 77, 59),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
