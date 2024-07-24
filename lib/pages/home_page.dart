import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pawsome_stays/widgets/custom_card.dart';
import 'package:pawsome_stays/widgets/custom_drawer.dart';

import '../widgets/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      drawer: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: const CustomDrawer(),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI(){
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/homebg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomCard(
                title: "Pet Profile",
                subtitle: "Manage profile!",
                icon: Icon(CupertinoIcons.paw),
                path: "/petProfile"
              ),
              CustomCard(
                  title: "Booking",
                  subtitle: "Book a bed now",
                  icon: Icon(Icons.calendar_month),
                path:"/booking"
              ),
              CustomCard(
                title: "Services",
                subtitle: "Register your pet for services!",
                icon: Icon(Icons.bathroom),
                path:"/petServices"
              ),
              CustomCard(
                  title: "Status",
                  subtitle: "Look at how your pet is doing!",
                  icon: Icon(Icons.photo),
                  path:"/status"
              ),
            ],
          )
        )
      )
    );
  }

}
