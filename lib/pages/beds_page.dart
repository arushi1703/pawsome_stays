import 'package:flutter/material.dart';
import 'package:image_card/image_card.dart';

import '../widgets/custom_appbar.dart';
import '../widgets/custom_drawer.dart';

class BedsPage extends StatelessWidget {
  const BedsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: 'Beds',),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Standard Beds',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 30),
            FillImageCard(
              heightImage: 200,
              imageProvider: AssetImage("images/basicbed.jpg"),
              title: const Text('Basic Bed : Rs 5000',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  fontWeight: FontWeight.w200
                ),
              ),
              tags: [],
              width: 320,
              description: const Text('A comfortable cushioned bed suitable for all types of pets'),
            ),
            SizedBox(height: 30),
            FillImageCard(
              heightImage: 200,
              imageProvider: AssetImage("images/bolsterbed.jpg"),
              title: const Text('Bolster Bed : Rs5000',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.w200
                ),
              ),
              description: const Text('Features raised sides or bolsters for pets that like to snuggle and feel secure.'),
            ),
            SizedBox(height: 30),
            const Text('Luxury Beds',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 30),
            FillImageCard(
              heightImage: 200,
              imageProvider: AssetImage("images/orthopedicbed.jpeg"),
              title: const Text('Orthopedic Bed: Rs 5000',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.w200
                ),
              ),
              width: 320,
              description: const Text('Made with memory foam, ideal for older pets or those with joint issues.'),
            ),
            SizedBox(height: 30),
            FillImageCard(
              heightImage: 200,
              imageProvider: AssetImage("images/heatedbed.jpg"),
              title: const Text('Heated Bed : Rs5000',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.w200
                ),
              ),
              width: 320,
              description: const Text('Provides warmth, great for pets that get cold easily.'),
            ),
          ],
        )
      )
    );
  }
}
