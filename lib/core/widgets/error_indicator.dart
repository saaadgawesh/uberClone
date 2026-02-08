import 'package:uberCloneRider/core/App_Imports/app_imports.dart';

class ErrorIndicator extends StatelessWidget {
  final String message;

  // ignore: use_key_in_widget_constructors
  const ErrorIndicator([this.message = 'Something went wrong!']);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: defaultElevatedButton(
        textbutton: message,
        bgButtonColor: AppColors.error,
        onPressed: () {
          context.pop();
        },
        width: appWidth(context),
        textcolor: AppColors.whiteColor,
      ),
    );
  }
}
