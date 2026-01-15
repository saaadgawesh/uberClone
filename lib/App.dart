import 'package:uberCloneDriver/l10n/app_localizations.dart';

import 'core/Imports/app_imports.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
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
          debugShowCheckedModeBanner: false,
          theme: Appthem.lighttheme,
          themeMode: settingsProvider.thememode,
          darkTheme: Appthem.darktheme,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.landingpage,
          locale: Locale(settingsProvider.language),
        ),
      ),
    );
  }
}
