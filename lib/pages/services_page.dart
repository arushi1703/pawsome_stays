import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_card/image_card.dart';

import '../services/navigation_service.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_drawer.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {

  final GetIt _getIt = GetIt.instance;
  late NavigationService _navigationService;

  @override
  void initState() {
    super.initState();
    _navigationService = _getIt.get<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: 'Services',),
      ),
      drawer: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomDrawer(),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI(){
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              GestureDetector(
                onTap:(){
                  _navigationService.pushNamed("/registerService");
                },
                child: const Text(
                  "Register my pet for Services !",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 17,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              const Text('Grooming Services',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 30),
              FillImageCard(
                heightImage: 200,
                imageProvider: AssetImage("images/fullgrooming.jpg"),
                title: const Text('Full Service Grooming : Rs 2000',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.w200
                  ),
                ),
                tags: [],
                width: 320,
                description: const Text('Includes a bath, haircut, nail trimming, ear cleaning, and brushing for a fresh and clean look.'),
              ),
              SizedBox(height: 30),
              FillImageCard(
                heightImage: 200,
                imageProvider: AssetImage("images/pawdicure.jpg"),
                title: const Text('Pawdicure : Rs 2000',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.w200
                  ),
                ),
                tags: [],
                width: 320,
                description: const Text('A specialized service for trimming and buffing nails, including a moisturizing paw massage.'),
              ),
              SizedBox(height: 30),
              FillImageCard(
                heightImage: 200,
                imageProvider: AssetImage("images/deshedding.jpg"),
                title: const Text('De-Shedding Treatment : Rs 2000',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.w200
                  ),
                ),
                tags: [],
                width: 320,
                description: const Text('Reduces shedding and keeps your pet’s coat healthy.'),
              ),
              SizedBox(height:30),
              const Text('Excercise and Wellness',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 30),
              FillImageCard(
                heightImage: 200,
                imageProvider: AssetImage("images/dailywalks.jpg"),
                title: const Text('Daily Walks : Rs 2000',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.w200
                  ),
                ),
                tags: [],
                width: 320,
                description: const Text('Regular walks tailored to the pet’s energy level and size.'),
              ),
              SizedBox(height:30),
              FillImageCard(
                heightImage: 200,
                imageProvider: AssetImage("images/petyoga.jpg"),
                title: const Text('Pet Yoga : Rs 2000',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.w200
                  ),
                ),
                tags: [],
                width: 320,
                description: const Text('Relaxing sessions designed to calm and stretch your pet’s muscles.'),
              ),
              SizedBox(height:30),
              FillImageCard(
                heightImage: 200,
                imageProvider: AssetImage("images/swimming.jpg"),
                title: const Text('Swimming Sessions : Rs 2000',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.w200
                  ),
                ),
                tags: [],
                width: 320,
                description: const Text('Safe and fun swimming time for water-loving pets, helping them stay fit.'),
              ),
            ]
          ),
        ),
    );
  }
}
