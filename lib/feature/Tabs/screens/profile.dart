import 'package:uberCloneRider/core/App_Imports/app_imports.dart';
import 'package:uberCloneRider/feature/Tabs/widgets/textfieldWithSectionTitle.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: "profile"),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Processitem(
                title: "saadGawesh",
                description: "flutter developer",
                leadIcon: Icons.edit,
                actionIcon: Icons.group,
                backgroundColor: context.bgColor,
                child: ClipOval(
                  child: Image.asset(
                    Assets.photo,
                    width: appWidth(context),
                    height: appHeight(context),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              heightSizedbox(10),
              Textfieldwithsectiontitle(text: 'Name', hinttext: 'saadGawesh'),
              heightSizedbox(10),
              Textfieldwithsectiontitle(
                text: 'phoneNo',
                hinttext: '01031214881',
              ),
              heightSizedbox(10),
              Textfieldwithsectiontitle(
                text: 'Email',
                hinttext: 'Saadgawesh@gmail.com',
              ),
              heightSizedbox(10),
              Textfieldwithsectiontitle(
                text: 'your job',
                hinttext: 'flutter developer',
              ),
              heightSizedbox(10),
            ],
          ),
        ),
      ),
    );
  }
}
