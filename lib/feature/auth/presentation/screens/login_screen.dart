import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uberCloneRider/core/resources/values_manager.dart';
import 'package:uberCloneRider/core/routing/routes.dart';
import 'package:uberCloneRider/core/widgets/loading_indicator.dart';
import 'package:uberCloneRider/feature/Auth/presentation/Cubit/Auth_Cubit.dart';
import 'package:uberCloneRider/feature/Auth/presentation/Cubit/Auth_State.dart';
import 'package:uberCloneRider/feature/Auth/presentation/widgets/BuildLoginForm.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Insets.s20.sp),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is SuccessAuthState) {
                    Navigator.pushReplacementNamed(context, Routes.navbar);
                  }

                  if (state is ErrorAuthState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("=====================error"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is LoadingAuthState) {
                      return const LoadingIndicator();
                    }

                    return BuildLoginForm(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      formKey: _formKey,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
