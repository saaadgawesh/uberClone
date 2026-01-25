import '../../../../core/App_Imports/app_imports.dart';

class BuildLoginForm extends StatelessWidget {
  const BuildLoginForm({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required GlobalKey<FormState> formKey,
  }) : _emailController = emailController,
       _passwordController = passwordController,
       _formKey = formKey;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    final applocalization = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Sizes.s100.h),

        Text(
          applocalization.welcomeBack,
          style: AppTextStyles.georgiaH3.copyWith(fontSize: FontSize.s24),
        ),

        SizedBox(height: Sizes.s8.h),

        Text(
          applocalization.pleasesigninwithyourmail,
          style: AppTextStyles.georgiaH3.copyWith(fontSize: FontSize.s16),
        ),

        SizedBox(height: Sizes.s50.h),

        AppTextField(
          controller: _emailController,
          labelText: applocalization.email,
          hintText: applocalization.enteryouremail,
          keyboardType: TextInputType.emailAddress,
          validator: (val) => Validator.validateEmail(val, context),
          filledColor: AppColors.whiteColor,
        ),

        SizedBox(height: Sizes.s28.h),

        AppTextField(
          controller: _passwordController,
          labelText: applocalization.password,
          hintText: applocalization.enteryourpassword,
          obscureText: true,
          keyboardType: TextInputType.text,
          validator: (val) => Validator.validatePassword(val, context),
          filledColor: AppColors.whiteColor,
        ),

        SizedBox(height: Sizes.s60.h),
        Center(
          child: defaultElevatedButton(
            textbutton: applocalization.login,
            textcolor: AppColors.whiteColor,
            bgButtonColor: context.bgColor,
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
              applocalization.donotHaveAnAccount,
              style: AppTextStyles.georgiaH3.copyWith(fontSize: FontSize.s16),
            ),
            Text(
              applocalization.questionMark,
              style: AppTextStyles.georgiaH3.copyWith(fontSize: FontSize.s16),
            ),
            SizedBox(width: Sizes.s8.w),
            GestureDetector(
              onTap: () => context.pushNamed(Routes.register),
              child: Text(
                applocalization.createAccount,
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
