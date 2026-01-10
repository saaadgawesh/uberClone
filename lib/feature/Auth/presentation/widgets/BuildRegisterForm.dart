// ignore: camel_case_types
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uberCloneDriver/core/constant/App_Color.dart';
import 'package:uberCloneDriver/core/extension/navigation.dart';
import 'package:uberCloneDriver/core/resources/AppTextStyles.dart';
import 'package:uberCloneDriver/core/resources/App_Size.dart';
import 'package:uberCloneDriver/core/resources/font_manager.dart';
import 'package:uberCloneDriver/core/resources/values_manager.dart';
import 'package:uberCloneDriver/core/routing/routes.dart';
import 'package:uberCloneDriver/core/utils/validator.dart';
import 'package:uberCloneDriver/core/widgets/App_TextField.dart';
import 'package:uberCloneDriver/core/widgets/defaultElevatedButton.dart';
import 'package:uberCloneDriver/feature/Auth/presentation/Cubit/Auth_Cubit.dart';

// ignore: unused_element
class BuildRegisterForm extends StatelessWidget {
  const BuildRegisterForm({
    super.key,
    required TextEditingController nameController,
    required TextEditingController phoneController,
    required TextEditingController emailController,
    required TextEditingController passwordController,

    required this.isLoading,
    required GlobalKey<FormState> formKey,
    required this.cardmodel,
    required this.cardnumber,
    required this.latController,
    required this.lngController,
  }) : _nameController = nameController,
       _phoneController = phoneController,
       _emailController = emailController,
       _passwordController = passwordController,
       _formKey = formKey;

  final TextEditingController _nameController;
  final TextEditingController _phoneController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController cardmodel;
  final TextEditingController cardnumber;
  final TextEditingController latController;
  final TextEditingController lngController;
  final bool isLoading;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: Sizes.s100.h),
        AppTextField(
          filledColor: AppColors.whiteColor,
          hintText: 'Enter your full name',
          labelText: 'Full Name',
          keyboardType: TextInputType.name,
          validator: Validator.validateFullName,
          controller: _nameController,
        ),
        SizedBox(height: Sizes.s18.h),

        AppTextField(
          hintText: 'Enter your mobile number',
          filledColor: AppColors.whiteColor,
          labelText: 'Mobile Number',
          validator: Validator.validatePhoneNumber,
          keyboardType: TextInputType.phone,
          controller: _phoneController,
        ),
        SizedBox(height: Sizes.s18.h),
        AppTextField(
          hintText: 'Enter your email address',
          filledColor: AppColors.whiteColor,
          labelText: 'E-mail Address',
          // validator: Validator.validateEmail,
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
        ),
        SizedBox(height: Sizes.s18.h),
        AppTextField(
          hintText: 'Enter your password',
          filledColor: AppColors.whiteColor,
          labelText: 'Password',
          validator: Validator.validatePassword,
          obscureText: true,
          keyboardType: TextInputType.text,
          controller: _passwordController,
        ),
        SizedBox(height: Sizes.s50.h),
        SizedBox(
          height: Sizes.s60.h,
          width: MediaQuery.of(context).size.width,
          child: defaultElevatedButton(
            textbutton: isLoading ? 'Loading...' : 'Register',
            bgButtonColor: AppColors.blueColor,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<AuthCubit>().register(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                  _nameController.text.trim(),
                  int.parse(_phoneController.text.trim()),
                  int.parse(cardmodel.text.trim()),
                  cardnumber.text.trim(),
                  GeoPoint(
                    double.parse(latController.text),
                    double.parse(lngController.text),
                  ),
                );
              }
            },
            textcolor: AppColors.whiteColor,
            width: appWidth(context),
          ),
        ),
        SizedBox(height: 30.h),

        /// 🔹 Login redirect
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account?',
              style: AppTextStyles.georgiaH3.copyWith(fontSize: FontSize.s16),
            ),
            SizedBox(width: Sizes.s8.w),
            GestureDetector(
              onTap: () => context.pushNamed(Routes.login),
              child: Text(
                'Login',
                style: AppTextStyles.georgiaH3.copyWith(fontSize: FontSize.s16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
