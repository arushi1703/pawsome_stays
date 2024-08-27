import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:pawsome_stays/pages/login_page.dart';
import 'package:pawsome_stays/services/auth_service.dart';
import 'package:pawsome_stays/services/backend_service.dart';
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
    _authService = GetIt.instance<AuthService>();
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
      /*initialRoute: _authService.user!= null? "/home":"/login",
      routes: _navigationService.routes,*/
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthService _authService;
  late BackendService _backendService;
  late NavigationService _navigationService;

  @override
  void initState() {
    super.initState();
    _authService = GetIt.instance<AuthService>();
    _backendService = GetIt.instance<BackendService>();
    _navigationService = GetIt.instance<NavigationService>();

    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    print("checking login state");
    if (_authService.user != null) {
      String email = _authService.user!.email!;
      String? ownerID = await _backendService.getOwnerIDByEmail(email);

      if (ownerID != null) {
        _navigationService.pushReplacementWithArguments("/home", ownerID);
      } else {
        _navigationService.pushReplacementNamed("/login");
      }
    } else {
      _navigationService.pushReplacementNamed("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}


