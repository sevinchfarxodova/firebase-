import 'package:firebase_signs/core/routes/route_names.dart';
import 'package:firebase_signs/pages/all_students_info_page.dart';
import 'package:firebase_signs/pages/firestore_pages/firestore_page.dart';
import 'package:firebase_signs/pages/firestore_pages/get_data_page.dart';
import 'package:firebase_signs/pages/home_page.dart';
import 'package:firebase_signs/pages/notification_page.dart';
import 'package:firebase_signs/pages/sign_in_page.dart';
import 'package:firebase_signs/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

class AppRoute {
  BuildContext context;

  AppRoute({required this.context});

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.signInPage:
        return MaterialPageRoute(builder: (_) => SignInPage());

      case RouteNames.signUpPage:
        return MaterialPageRoute(builder: (_) => SignUpPage());

      case RouteNames.homePage:
        return MaterialPageRoute(builder: (_) => HomePage());

      case RouteNames.all_students_info_page:
        return MaterialPageRoute(builder: (_) => AllStudentsInfoPage());

      case RouteNames.fireStorePage:
        return MaterialPageRoute(builder: (_) => FirestorePage());

      case RouteNames.fireStoreStudentsPage:
        return MaterialPageRoute(builder: (_) => AllFireStoreStudentsInfoPage());

      default:
        return _errorRoute();
    }
  }

  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Page not found')),
          ),
    );
  }
}
