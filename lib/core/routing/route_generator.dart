import '../Imports/app_imports.dart';
class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
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
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => Profile(), settings: settings);

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
