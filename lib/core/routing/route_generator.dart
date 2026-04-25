import 'package:uberCloneRider/feature/Tabs/widgets/myTrips.dart';
import 'package:uberCloneRider/feature/Tabs/widgets/offers.dart';
import 'package:uberCloneRider/feature/Tabs/widgets/thelastTrips.dart';
import 'package:uberCloneRider/feature/Tabs/widgets/walletPage.dart';

import '../../../core/App_Imports/app_imports.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    // Check if user is authenticated for protected routes
    bool isAuthenticated = FirebaseAuth.instance.currentUser != null;
    List<String> protectedRoutes = [
      Routes.navbar,
      Routes.home,
      Routes.profile,
      Routes.myrequests,
      Routes.requestcar,
      Routes.searchingForDriverScreen,
      Routes.paymentmethods,
      Routes.walletpage,
      Routes.mytrip,
      Routes.thelastTrips,
      Routes.offers,
      Routes.tripSummary,
    ];

    if (protectedRoutes.contains(settings.name) && !isAuthenticated) {
      return MaterialPageRoute(
        builder: (_) => const LoginScreen(),
        settings: settings,
      );
    }

    switch (settings.name) {
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
          settings: settings,
        );
      case Routes.thelastTrips:
        return MaterialPageRoute(
          builder: (_) => const thelastTrips(),
          settings: settings,
        );
      case Routes.mytrip:
        return MaterialPageRoute(
          builder: (_) => const myTrips(),
          settings: settings,
        );
      case Routes.offers:
        return MaterialPageRoute(
          builder: (_) => const offers(),
          settings: settings,
        );
      case Routes.searchingForDriverScreen:
        return MaterialPageRoute(
          builder: (_) => const SearchingForDriverScreen(),
          settings: settings,
        );
      case Routes.walletpage:
        return MaterialPageRoute(
          builder: (_) => const Walletpage(),
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
      case Routes.splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case Routes.paymentmethods:
        return MaterialPageRoute(
          builder: (_) => const PaymentMethod(),
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
        return MaterialPageRoute(builder: (_) => const MyRequests());
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
