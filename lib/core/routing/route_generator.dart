import 'package:flutter/material.dart';
import 'package:uberCloneRider/core/routing/routes.dart';
import 'package:uberCloneRider/feature/Auth/presentation/screens/login_screen.dart';
import 'package:uberCloneRider/feature/Auth/presentation/screens/register_screen.dart';
import 'package:uberCloneRider/feature/LandingPages/screens/landingPage.dart';
import 'package:uberCloneRider/feature/NavBar/screens/NavBar.dart';
import 'package:uberCloneRider/feature/Tabs/screens/home.dart';
import 'package:uberCloneRider/feature/Tabs/screens/myRequests.dart';
import 'package:uberCloneRider/feature/Tabs/screens/profile.dart';
import 'package:uberCloneRider/feature/SearchingForDriverScreen/screen/SearchingForDriverScreen.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
          settings: settings,
        );
      case Routes.SearchingForDriverScreen:
        return MaterialPageRoute(
          builder: (_) => const SearchingForDriverScreen(),
          settings: settings,
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const Home(),
          settings: settings,
        );
      case Routes.navbar:
        return MaterialPageRoute(
          builder: (_) => const Navbar(),
          settings: settings,
        );
      case Routes.landingpage:
        return MaterialPageRoute(
          builder: (_) => const Landingpage(),
          settings: settings,
        );
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => Profile(), settings: settings);
      // case Routes.tripSummary:
      //   return MaterialPageRoute(
      //     builder: (_) => TripSummaryScreen(),
      //     settings: settings,
      //   );
      case Routes.myrequests:
        return MaterialPageRoute(builder: (_) => const Myrequests());
      default:
        return _undefinedRoute();
    }
  }

  static Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found'), centerTitle: true),
        body: Container(
          decoration: const BoxDecoration(color: Colors.red),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [const Text('No Route Found')],
          ),
        ),
      ),
    );
  }
}
