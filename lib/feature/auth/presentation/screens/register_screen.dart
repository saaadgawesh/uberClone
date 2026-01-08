import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uberCloneRider/core/resources/values_manager.dart';
import 'package:uberCloneRider/core/widgets/error_indicator.dart';
import 'package:uberCloneRider/feature/auth/presentation/Cubit/Auth_Cubit.dart';
import 'package:uberCloneRider/feature/auth/presentation/Cubit/Auth_State.dart';
import 'package:uberCloneRider/feature/auth/presentation/widgets/BuildRegisterForm.dart';
import 'package:uberCloneRider/feature/navBar/screens/NavBar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                      Navigator.pop(context); // يغلق أي Loading
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Center(child: Text('Login successful!')),
                        ),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const Navbar()),
                      );
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
