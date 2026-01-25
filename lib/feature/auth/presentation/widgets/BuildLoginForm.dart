

import '../../../../core/App_Imports/app_imports.dart';

class BuildLoginForm extends StatefulWidget {
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
  State<BuildLoginForm> createState() => _BuildLoginFormState();
}

class _BuildLoginFormState extends State<BuildLoginForm> {
  String password = '';
  bool get length => password.length >= 8;
  bool get uperCase => password.contains(RegExp(r'[A-Z]'));
  bool get lowerCase => password.contains(RegExp(r'[a-z]'));
  bool get number => password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>0-9]'));

  bool isobsecured = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VSpace(Sizes.s100.h),

        Text(
          'Welcome Back',
          style: AppTextStyles.georgiaH3.copyWith(fontSize: FontSize.s24),
        ),

        VSpace(Sizes.s8.h),

        Text(
          'Please sign in with your mail',
          style: AppTextStyles.georgiaH3.copyWith(fontSize: FontSize.s16),
        ),

        VSpace(Sizes.s50.h),

        AppTextField(
          controller: widget._emailController,
          labelText: 'Email',
          hintText: 'enter your email',
          keyboardType: TextInputType.emailAddress,
          validator: Validator.validateEmail,
          filledColor: AppColors.whiteColor,
        ),

        VSpace(Sizes.s28.h),

        AppTextField(
          suffix: IconButton(
            onPressed: () {
              setState(() {
                isobsecured = !isobsecured;
              });
            },
            icon: isobsecured
                ? customAppIcon(
                    iconColor: AppColors.blackColor,
                    iconName: Icons.visibility_off,
                  )
                : customAppIcon(
                    iconName: Icons.visibility,
                    iconColor: AppColors.grey,
                  ),
          ),
          obscureText: isobsecured,
          controller: widget._passwordController,
          labelText: 'Password',
          hintText: 'enter your password',
          // obscureText: true,
          keyboardType: TextInputType.text,
          validator: Validator.validatePassword,
          filledColor: AppColors.whiteColor,
          onChange: (value) {
            setState(() {
              password = value;
            });
          },
        ),

        VSpace(15),
        validateItem(isvalid: length, text: '8 characters Minimum'),
        VSpace(5),
        validateItem(isvalid: uperCase, text: 'At least 1 uppercase letter'),
        VSpace(5),
        validateItem(isvalid: lowerCase, text: 'At least 1 lowercase letter'),
        VSpace(5),
        validateItem(isvalid: number, text: 'One special character and number'),
        VSpace(Sizes.s60.h),
        Center(
          child: defaultElevatedButton(
            textbutton: 'Login',
            textcolor: AppColors.whiteColor,
            bgButtonColor: context.bgColor,
            width: appWidth(context),
            onPressed: () {
              if (widget._formKey.currentState!.validate()) {
                context.read<AuthCubit>().login(
                  widget._emailController.text.trim(),
                  widget._passwordController.text.trim(),
                );
              }
            },
          ),
        ),

        VSpace(Sizes.s10.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don’t have an account?',
              style: AppTextStyles.georgiaH3.copyWith(fontSize: FontSize.s16),
            ),
            HSpace(Sizes.s8.w),
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
