import 'package:flutter/cupertino.dart';
import 'package:pawsome_stays/pages/beds_page.dart';
import 'package:pawsome_stays/pages/booking_page.dart';
import 'package:pawsome_stays/pages/home_page.dart';
import 'package:pawsome_stays/pages/login_page.dart';
import 'package:pawsome_stays/pages/payment_page.dart';
import 'package:pawsome_stays/pages/petRegister_page.dart';
import 'package:pawsome_stays/pages/register_page.dart';
import 'package:pawsome_stays/pages/services_page.dart';
import 'package:pawsome_stays/pages/status_page.dart';

import '../pages/registerServicePage.dart';

class NavigationService{

  late GlobalKey<NavigatorState> _navigatorKey;

  final Map<String, Widget Function(BuildContext)> _routes = {
    "/login": (context) => LoginPage(),
    "/home" : (context) => HomePage(),
    "/register" : (context) => RegisterPage(),
    "/Petregister" : (context) => PetregisterPage(),
    "/booking" : (context) => BookingPage(),
    "/payment" : (context) => PaymentPage(),
    "/status" : (context) => StatusPage(),
    "/beds" : (context) => BedsPage(),
    "/services": (context) => ServicesPage(),
    "/registerService" : (context) => RegisterServicePage(),
  };

  GlobalKey<NavigatorState>? get navigatorKey{
    return _navigatorKey;
  }

  Map<String, Widget Function(BuildContext)> get routes{
    return _routes;
  }

  NavigationService(){
    //setting navigatorKey to a new instance of a global key
    _navigatorKey= GlobalKey<NavigatorState>();
  }

  void pushNamed(String routeName){
    _navigatorKey.currentState?.pushNamed(routeName);
  }

  void pushReplacementNamed(String routeName){
    _navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  void goBack(){
    _navigatorKey.currentState?.pop();
  }
}