import '../../../../core/Imports/app_imports.dart';

class Requests extends StatelessWidget {
  final DriverRepository driverRepo = DriverRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'طلباتك',
        leadIconName: Icons.arrow_back_ios,
        leadingonTap: () {},
      ),
    );
  }
}
