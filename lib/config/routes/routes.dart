import 'package:flutter/material.dart';
import 'package:machine_test/features/home/presentation/pages/home.dart';
import 'package:machine_test/features/home/presentation/pages/orderpage.dart';

import '../../features/app/splash/page/splash_screen.dart';
import '../../features/profile/presentation/pages/profile.dart';
import '../../features/signin/presentation/pages/signin.dart';
import '../../features/signup/presentation/pages/signup.dart';


class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const SplashScreen());

      case '/Signup':
        return _materialRoute(const Signup());

      case '/Signin':
        return _materialRoute(const Signin());

      case '/Home':
        return _materialRoute(const Home());

      case '/OrderPage':
        return _materialRoute(OrdersPage());

      default:
        return _materialRoute(const SplashScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
