import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uberCloneDriver/core/extension/navigation.dart';
import 'package:uberCloneDriver/core/resources/values_manager.dart';
import 'package:uberCloneDriver/core/routing/routes.dart';
import 'package:uberCloneDriver/core/widgets/error_indicator.dart';
import 'package:uberCloneDriver/feature/Auth/presentation/Cubit/Auth_Cubit.dart';
import 'package:uberCloneDriver/feature/Auth/presentation/Cubit/Auth_State.dart';
import 'package:uberCloneDriver/feature/Auth/presentation/widgets/BuildRegisterForm.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cardmodel = TextEditingController();
  final _cardnumber = TextEditingController();
  final _latController = TextEditingController();
  final _lngController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.s20.w,
              vertical: Sizes.s20.h,
            ),
            child: Form(
              key: _formKey,
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is SuccessAuthState) {
                    // تنفيذ الـ navigation بعد أول frame
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.pop(); // يغلق أي Loading
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                        behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                          content: Center(child: Text('Register successful!')),
                        ),
                      );

                      context.pushReplacementNamed(Routes.login);
                    });
                  } else if (state is ErrorAuthState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Center(child: ErrorIndicator(state.e));
                    });
                  }
                },
                builder: (context, state) {
                  final isLoading = state is LoadingAuthState;

                  return BuildRegisterForm(
                    nameController: _nameController,
                    phoneController: _phoneController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    isLoading: isLoading,
                    formKey: _formKey,
                    cardmodelcontroller: _cardmodel,
                    carnumbercontroller: _cardnumber,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
