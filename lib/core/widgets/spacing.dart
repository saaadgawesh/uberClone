import '../../core/App_Imports/app_imports.dart';

class VSpace extends StatelessWidget {
  final double height;
  const VSpace(this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height.h);
  }
}

class HSpace extends StatelessWidget {
  final double width;
  const HSpace(this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width.w);
  }
}
