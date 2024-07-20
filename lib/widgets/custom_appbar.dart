import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue[500],
      title: Text('Pawsome Stays',
        style: TextStyle(
          color: Colors.white,
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
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
