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
    final ownerID = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: 'Pawsome Stays',),
      ),
      drawer: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: const CustomDrawer(),
      ),
      body: _buildUI(ownerID),
    );
  }

  Widget _buildUI(String ownerID){
    print('This is owner id in home page:${ownerID}');
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
                title: "My Pet",
                subtitle: "Manage services and more for your pet!",
                icon: Icon(CupertinoIcons.paw),
                path: "/petProfile"
              ),
              SizedBox(height:30),
              CustomCard(
                  title: "Booking",
                  subtitle: "Book a bed now",
                  icon: Icon(Icons.calendar_month),
                path:"/booking"
              ),
              SizedBox(height:30),
              CustomCard(
                title: "Services",
                subtitle: "Register your pet for luxury services!",
                icon: Icon(Icons.bathroom),
                path:"/services"
              ),
              SizedBox(height:30),
              CustomCard(
                  title: "Status",
                  subtitle: "Look at how your pet is doing!",
                  icon: Icon(Icons.photo),
                  path:"/status"
              ),
              SizedBox(height:30),
              CustomCard(
                  title: "Beds",
                  subtitle: "Browse through our collection of beds",
                  icon: Icon(Icons.bed_rounded),
                  path:"/beds"
              ),
            ],
          )
        )
      )
    );
  }

}
