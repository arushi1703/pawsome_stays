import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:[
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/logo.jpg"),
                fit : BoxFit.fill,
              )
            ),
            child: null,
          ),
          ListTile(
            title: const Text('L O G O U T',
              style: TextStyle(color: Colors.blue,),
            ),
            onTap: (){},
          )
        ],
      ),
    );
  }
}
