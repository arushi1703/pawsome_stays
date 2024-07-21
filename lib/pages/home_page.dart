

import 'package:flutter/material.dart';
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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(),
      ),
      drawer: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: const CustomDrawer(),
      ),
    );
  }
}
