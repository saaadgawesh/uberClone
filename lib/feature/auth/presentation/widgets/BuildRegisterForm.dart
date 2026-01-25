import"../../../../core/App_Imports/app_imports.dart";
class BuildRegisterForm extends StatefulWidget {
  const BuildRegisterForm({
    super.key,
    required TextEditingController nameController,
    required TextEditingController phoneController,
    required TextEditingController emailController,
    required TextEditingController passwordController,

    required this.isLoading,
    required GlobalKey<FormState> formKey,
  }) : _nameController = nameController,
       _phoneController = phoneController,
       _emailController = emailController,
       _passwordController = passwordController,
       _formKey = formKey;

  final TextEditingController _nameController;
  final TextEditingController _phoneController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  final bool isLoading;
  final GlobalKey<FormState> _formKey;

  @override
  State<BuildRegisterForm> createState() => _BuildRegisterFormState();
}

class _BuildRegisterFormState extends State<BuildRegisterForm> {
  GeoPoint? currentLocation;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: Sizes.s20.h),
        AppTextField(
          filledColor: AppColors.whiteColor,
          hintText: 'Enter your full name',
          labelText: 'Full Name',
          keyboardType: TextInputType.name,
          validator: Validator.validateFullName,
          controller: widget._nameController,
        ),
        SizedBox(height: Sizes.s18.h),

        AppTextField(
          hintText: 'Enter your mobile number',
          filledColor: AppColors.whiteColor,
          labelText: 'Mobile Number',
          validator: Validator.validatePhoneNumber,
          keyboardType: TextInputType.phone,
          controller: widget._phoneController,
        ),
        SizedBox(height: Sizes.s18.h),
        AppTextField(
          hintText: 'Enter your email address',
          filledColor: AppColors.whiteColor,
          labelText: 'E-mail Address',
          // validator: Validator.validateEmail,
          keyboardType: TextInputType.emailAddress,
          controller: widget._emailController,
        ),
        SizedBox(height: Sizes.s18.h),

        AppTextField(
          hintText: 'Enter your password',
          filledColor: AppColors.whiteColor,
          labelText: 'Password',
          validator: Validator.validatePassword,
          obscureText: true,
          keyboardType: TextInputType.text,
          controller: widget._passwordController,
        ),

        SizedBox(height: Sizes.s20.h),
        SizedBox(
          height: Sizes.s60.h,
          width: MediaQuery.of(context).size.width,
          child: defaultElevatedButton(
            textbutton: widget.isLoading ? 'Loading...' : 'Register',
            bgButtonColor: AppColors.blueColor,
            onPressed: () {
              context.read<AuthCubit>().register(
                widget._emailController.text.trim(),
                widget._passwordController.text.trim(),
                widget._nameController.text.trim(),
                int.parse(widget._phoneController.text.trim()),
              );
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
