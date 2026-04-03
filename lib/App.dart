import 'package:uberCloneDriver/core/widgets/getStartScreen.dart';
import 'package:uberCloneDriver/feature/Auth/data/repositories/auth_repository_impl.dart';
import 'package:uberCloneDriver/feature/Auth/domain/use_cases/login_use_case.dart';
import 'package:uberCloneDriver/feature/Auth/domain/use_cases/logout_use_case.dart';
import 'package:uberCloneDriver/feature/Auth/domain/use_cases/register_use_case.dart';

import 'core/Imports/app_imports.dart';

class App extends StatelessWidget {


  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    final authrepo = AuthRepositoryImpl(_);
    final registeruser = RegisterUseCase(authrepo);
    final loginuser = LoginUseCase(authrepo);
    final logoutuser = LogoutUseCase( authrepo);
    return BlocProvider(
      create: (context) => AuthCubit(registeruser, loginuser, logoutuser),
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          theme: Appthem.lighttheme,
          themeMode: settingsProvider.themeMode,
          darkTheme: Appthem.darktheme,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: user == null ? Routes.login : Routes.navbar,
          locale: Locale(settingsProvider.languauge),
          home: getStartScreen(),
        ),
      ),
    );
  }
}
