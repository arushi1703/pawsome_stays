import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {

  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.blue, // Change this to the desired color
      ),
      backgroundColor: Colors.white,
      title: Text(title,
        style: TextStyle(
          color: Colors.blue,
      ),
      ),
      //leading: Icon(Icons.account_circle_rounded),
      actions:<Widget>[
        IconButton(
          onPressed: (){
            //Navigator.push(context,MaterialPageRoute(builder: (context) => const ProfilePage(title: 'Profile',)));
          },
          icon: const Icon(
            Icons.settings,
            size: 25,
          ),
        )
      ],
    );
  }
}
