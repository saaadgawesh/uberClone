import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uberCloneRider/core/constant/appThem.dart';
import 'package:uberCloneRider/core/routing/route_generator.dart';
import 'package:uberCloneRider/core/routing/routes.dart';
import 'package:uberCloneRider/feature/Auth/DomainLayer/Repositoryimpl/Auth_Repository_impl.dart';
import 'package:uberCloneRider/feature/Auth/DomainLayer/UserCases/LoginUser.dart';
import 'package:uberCloneRider/feature/Auth/DomainLayer/UserCases/RegisterUser.dart';
import 'package:uberCloneRider/feature/Auth/presentation/Cubit/Auth_Cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
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
          debugShowCheckedModeBanner: false,
          theme: Appthem.lighttheme,
          themeMode: ThemeMode.light,
          darkTheme: Appthem.lighttheme,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.login,
        ),
      ),
    );
  }
}
