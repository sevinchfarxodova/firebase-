import 'package:firebase_signs/core/routes/route_generator.dart';
import 'package:firebase_signs/core/routes/route_names.dart';
import 'package:firebase_signs/pages/home_page.dart';
import 'package:firebase_signs/services/notification_firebase.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAPI().initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.signUpPage,
      onGenerateRoute: AppRoute(context: context).onGenerateRoute,
      navigatorKey: navigatorKey,
      routes: {'/homePage': (context) => HomePage()},
    );
  }
}
