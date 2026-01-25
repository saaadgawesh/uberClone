// ignore: camel_case_types

import '../../../../core/App_Imports/app_imports.dart';

// ignore: unused_element
class BuildRegisterForm extends StatefulWidget {
  const BuildRegisterForm({
    super.key,
    required TextEditingController nameController,
    required TextEditingController phoneController,
    required TextEditingController emailController,
    required TextEditingController passwordController,

    required this.isLoading,
    required GlobalKey<FormState> formKey,
    required this.cardmodelcontroller,
    required this.carnumbercontroller,
  }) : _nameController = nameController,
       _phoneController = phoneController,
       _emailController = emailController,
       _passwordController = passwordController,
       _formKey = formKey;

  final TextEditingController _nameController;
  final TextEditingController _phoneController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController cardmodelcontroller;
  final TextEditingController carnumbercontroller;

  final bool isLoading;
  final GlobalKey<FormState> _formKey;

  @override
  State<BuildRegisterForm> createState() => _BuildRegisterFormState();
}

class _BuildRegisterFormState extends State<BuildRegisterForm> {
  GeoPoint? currentLocation;

  @override
  Widget build(BuildContext context) {
    final applocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: Sizes.s20.h),
        AppTextField(
          filledColor: AppColors.whiteColor,
          hintText: applocalizations.enteryourfullname,
          labelText: applocalizations.fullName,
          keyboardType: TextInputType.name,
          validator: (val) => Validator.validateFullName(val, context),
          controller: widget._nameController,
        ),
        SizedBox(height: Sizes.s18.h),

        AppTextField(
          hintText:applocalizations.enteryourmobilenumber,
          filledColor: AppColors.whiteColor,
          labelText: applocalizations.mobileNumber,
          validator: (val) => Validator.validatePhoneNumber(val, context),
          keyboardType: TextInputType.phone,
          controller: widget._phoneController,
        ),
        SizedBox(height: Sizes.s18.h),
        AppTextField(
          hintText: applocalizations.enteryouremail,
          filledColor: AppColors.whiteColor,
          labelText: applocalizations.email,
          // validator: Validator.validateEmail,
          keyboardType: TextInputType.emailAddress,
          controller: widget._emailController,
        ),
        SizedBox(height: Sizes.s18.h),
        AppTextField(
          hintText: applocalizations.enteryourcarmodel,
          filledColor: AppColors.whiteColor,
          labelText: applocalizations.carModel,
          // validator: Validator.validateEmail,
          // keyboardType: TextInputType.emailAddress,
          controller: widget.cardmodelcontroller,
        ),
        SizedBox(height: Sizes.s18.h),
        AppTextField(
          hintText: applocalizations.enteryourcarNumber,
          filledColor: AppColors.whiteColor,
          labelText: applocalizations.carNumber,
          // validator: Validator.validateEmail,
          keyboardType: TextInputType.emailAddress,
          controller: widget.carnumbercontroller,
        ),
        SizedBox(height: Sizes.s18.h),
        AppTextField(
          hintText: applocalizations.enteryourpassword,
          filledColor: AppColors.whiteColor,
          labelText: applocalizations.password,
          validator: (val) => Validator.validatePassword(val, context),

          obscureText: true,
          keyboardType: TextInputType.text,
          controller: widget._passwordController,
        ),
        SizedBox(height: Sizes.s20.h),
        defaultElevatedButton(
          onPressed: () async {
            final locationManager = LocationManager();

            final locationData = await locationManager.getUserLocation();
            if (locationData != null) {
              final geoPoint = GeoPoint(
                locationData.latitude!,
                locationData.longitude!,
              );
              setState(() {
                currentLocation = geoPoint; // متغير في StatefulWidget
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: AppColors.greenColor,
                  content: CustomAppText(
                    text: applocalizations.locationfetched,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text("Permission denied or service disabled"),
                ),
              );
            }
          },
          textbutton: applocalizations.getCurrentLocation,
          bgButtonColor: context.bgColor,
          width: appWidth(context),
          textcolor: AppColors.whiteColor,
        ),
        SizedBox(height: Sizes.s10.h),
        SizedBox(
          height: Sizes.s60.h,
          width: MediaQuery.of(context).size.width,
          child: defaultElevatedButton(
            textbutton: widget.isLoading
                ? applocalizations.loading
                : applocalizations.register,
            bgButtonColor: context.bgColor,
            onPressed: () {
              if (widget._formKey.currentState!.validate()) {
                if (currentLocation == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: AppColors.error,
                      content: Text(
                        applocalizations.pleasegetyourcurrentlocationfirst,
                      ),
                    ),
                  );
                  return;
                }

                context.read<AuthCubit>().register(
                  widget._emailController.text.trim(),
                  widget._passwordController.text.trim(),
                  widget._nameController.text.trim(),
                  int.parse(widget._phoneController.text.trim()),
                  int.parse(widget.cardmodelcontroller.text.trim()),
                  widget.carnumbercontroller.text.trim(),
                  currentLocation!, // استخدم المتغير مباشرة
                );
              }
            },
            textcolor: AppColors.whiteColor,
            width: appWidth(context),
          ),
        ),
        SizedBox(height: 10.h),

        /// 🔹 Login redirect
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              applocalizations.alreadyhaveanaccount,
              style: AppTextStyles.georgiaH3.copyWith(fontSize: FontSize.s16),
            ),
            SizedBox(width: Sizes.s8.w),
            GestureDetector(
              onTap: () => context.pushNamed(Routes.login),
              child: Text(
                applocalizations.login,
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
