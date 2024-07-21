import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pawsome_stays/services/alert_service.dart';

import '../services/auth_service.dart';
import '../services/navigation_service.dart';
//import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final GetIt _getIt = GetIt.instance;

  late AuthService _authService;
  late NavigationService _navigationService;
  late AlertService _alertService;

  @override
  void initState() {
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _alertService = _getIt.get<AlertService>();
  }

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
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.logout_outlined,
                  color: Colors.blue,
                ),
                const Text('L O G O U T',
                  style: TextStyle(color: Colors.blue,),
                ),
              ],
            ),
            onTap: () async{
              bool result = await _authService.logout();
              if (result){
                _alertService.showToast(
                  text: "Successfully logged out",
                  icon: Icons.check,
                );
                _navigationService.pushReplacementNamed("/login");
              }
            },
          )
        ],
      ),
    );
  }
}
