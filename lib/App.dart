import 'package:uberCloneRider/core/di/service_Locator.dart';

import 'core/App_Imports/app_imports.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationService().setNavigatorKey(navigatorKey);
      NotificationService().setUserRole(UserRole.rider);
      NotificationService().setUserCollection('Rider');
      NotificationService().init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return BlocProvider(
      create: (context) => servicelocator<AuthCubit>(),
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: Appthem.lighttheme,
          themeMode: ThemeMode.light,
          darkTheme: Appthem.lighttheme,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.splashScreen,
          locale: Locale(settingsProvider.languauge),
        ),
      ),
    );
  }
}
