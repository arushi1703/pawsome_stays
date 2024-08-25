import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pawsome_stays/firebase_options.dart';
import 'package:pawsome_stays/services/alert_service.dart';
import 'package:pawsome_stays/services/auth_service.dart';
import 'package:pawsome_stays/services/backend_service.dart';
import 'package:pawsome_stays/services/media_service.dart';
import 'package:pawsome_stays/services/navigation_service.dart';

Future<void> setupFirebase() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> registerServices() async{
  final GetIt getIt = GetIt.instance;

  getIt.registerSingleton<AuthService>(
    AuthService(),
  );

  getIt.registerSingleton<NavigationService>(
    NavigationService(),
  );

  getIt.registerSingleton<AlertService>(
    AlertService(),
  );

  getIt.registerSingleton<MediaService>(
    MediaService(),
  );

  getIt.registerSingleton<BackendService>(
    BackendService(),
  );
}