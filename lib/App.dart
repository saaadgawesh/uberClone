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
      NotificationService().init();
      NotificationService().setUserRole(UserRole.driver);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Settingprovider settingprovider = Provider.of<Settingprovider>(context);
    final authrepo = AuthRepositoryImpl();
    final registeruser = Registeruser(authrepo);
    final loginuser = Loginuser(authrepo);
    return BlocProvider(
      create: (context) => AuthCubit(registeruser, loginuser),
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
          themeMode: settingprovider.themeMode,
          darkTheme: Appthem.lighttheme,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.login,
          locale: Locale(settingprovider.languauge),
        ),
      ),
    );
  }
}
