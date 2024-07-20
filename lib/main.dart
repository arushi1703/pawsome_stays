import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pawsome_stays/pages/login_page.dart';
import 'package:pawsome_stays/services/auth_service.dart';
import 'package:pawsome_stays/services/navigation_service.dart';
import 'package:pawsome_stays/utils.dart';

void main() async{
  await setUp();
  runApp(MyApp());
}

Future<void> setUp() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
  await registerServices();
}

class MyApp extends StatelessWidget {

  final GetIt _getIt = GetIt.instance;
  late NavigationService _navigationService;
  late AuthService _authService;

  MyApp({super.key}){
    _navigationService = _getIt.get<NavigationService>();
    _authService = _getIt.get<AuthService>();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigationService.navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.hankenGroteskTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      //home: const LoginPage(),
      initialRoute: _authService.user!= null? "/home":"/login",
      routes: _navigationService.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}

