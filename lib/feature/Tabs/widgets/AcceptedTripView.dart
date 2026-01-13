// import 'package:flutter/material.dart';
// import 'package:uberCloneRider/core/constant/App_Color.dart';
// import 'package:uberCloneRider/core/resources/App_Size.dart';
// import 'package:uberCloneRider/core/resources/CustomAppText.dart';
// import 'package:uberCloneRider/core/widgets/CustomContainer.dart';
// import 'package:uberCloneRider/core/widgets/spacing.dart';
// import 'package:uberCloneRider/feature/Tabs/widgets/openRouteInGoogleMaps.dart';

// class AcceptedTripView extends StatelessWidget {
//   final Map<String, dynamic> trip;

//   const AcceptedTripView({required this.trip});

//   @override
//   Widget build(BuildContext context) {

//     final fromLat = (trip['fromLat'] as num).toDouble();
//     final fromLng = (trip['fromLng'] as num).toDouble();
//     final toLat = (trip['toLat'] as num).toDouble();
//     final toLng = (trip['toLng'] as num).toDouble();

//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [

//           CustomAppText(text: 'السائق في الطريق 🚗'),
//           VSpace(10),
//           CustomAppText(text: 'السعر: ${trip['price']}'),

//           VSpace(20),
//           InkWell(
//             onTap: () {
//               openRouteInGoogleMaps(
//                 fromLat: fromLat,
//                 fromLng: fromLng,
//                 toLat: toLat,
//                 toLng: toLng,
//               );
//             },
//             child: Row(
//               children: [
//                 Icon(Icons.map, color: Colors.blue),
//                 SizedBox(width: 8),
//                 Text('فتح المسار على الخريطة'),
//               ],
//             ),
//           ),

//           VSpace(30),

//           CustomContainer(
//             height: 50,
//             bgContainerColor: AppColors.greenColor,
//              width: appWidth(context),
//             child: Center(
//               child: CustomAppText(
//                 text: 'تم قبول الرحلة',
//                 textColor: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
