import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uberCloneRider/core/constant/App_Color.dart';
import 'package:uberCloneRider/core/extension/navigation.dart';
import 'package:uberCloneRider/core/resources/AppTextStyles.dart';
import 'package:uberCloneRider/core/resources/App_Size.dart';
import 'package:uberCloneRider/core/resources/font_manager.dart';
import 'package:uberCloneRider/core/resources/values_manager.dart';
import 'package:uberCloneRider/core/routing/routes.dart';
import 'package:uberCloneRider/core/utils/validator.dart';
import 'package:uberCloneRider/core/widgets/App_TextField.dart';
import 'package:uberCloneRider/core/widgets/defaultElevatedButton.dart';
import 'package:uberCloneRider/feature/Auth/presentation/Cubit/Auth_Cubit.dart';

class BuildLoginForm extends StatelessWidget {
  const BuildLoginForm({
    super.key,
    required this.isLoading,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required GlobalKey<FormState> formKey,
  }) : _emailController = emailController,
       _passwordController = passwordController,
       _formKey = formKey;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Sizes.s100.h),

        Text(
          'Welcome Back',
          style: AppTextStyles.georgiaH3.copyWith(fontSize: FontSize.s24),
        ),

        SizedBox(height: Sizes.s8.h),

        Text(
          'Please sign in with your mail',
          style: AppTextStyles.georgiaH3.copyWith(fontSize: FontSize.s16),
        ),

        SizedBox(height: Sizes.s50.h),

        AppTextField(
          controller: _emailController,
          labelText: 'Email',
          hintText: 'enter your email',
          keyboardType: TextInputType.emailAddress,
          validator: Validator.validateEmail,
          filledColor: AppColors.whiteColor,
        ),

        SizedBox(height: Sizes.s28.h),

        AppTextField(
          controller: _passwordController,
          labelText: 'Password',
          hintText: 'enter your password',
          obscureText: true,
          keyboardType: TextInputType.text,
          validator: Validator.validatePassword,
          filledColor: AppColors.whiteColor,
        ),

        SizedBox(height: Sizes.s60.h),
        Center(
          child: defaultElevatedButton(
            textbutton: 'Login',
            textcolor: AppColors.whiteColor,
            bgButtonColor: AppColors.blueColor,
            width: appWidth(context),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<AuthCubit>().login(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );
              }
            },
          ),
        ),

        SizedBox(height: Sizes.s10.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don’t have an account?',
              style: AppTextStyles.georgiaH3.copyWith(fontSize: FontSize.s16),
            ),
            SizedBox(width: Sizes.s8.w),
            GestureDetector(
              onTap: () => context.pushNamed(Routes.register),
              child: Text(
                'Create Account',
                style: AppTextStyles.georgiaH3.copyWith(
                  fontSize: FontSize.s16,
                  color: AppColors.blueColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
