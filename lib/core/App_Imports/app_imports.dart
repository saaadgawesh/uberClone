// app_exports.dart

// ================== Dart & Flutter ==================
export 'dart:convert';

export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:dio/dio.dart';
// ================== Firebase ==================
export 'package:firebase_auth/firebase_auth.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:flutter/material.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
// ================== Map & Location ==================
export 'package:flutter_map/flutter_map.dart';
export 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:uberCloneRider/App.dart';
// ================== Core ==================
export 'package:uberCloneRider/core/constant/App_Color.dart';
export 'package:uberCloneRider/core/constant/appThem.dart';
export 'package:uberCloneRider/core/constant/assets.dart';
export 'package:uberCloneRider/core/extension/navigation.dart';
export 'package:uberCloneRider/core/resources/AppDivider.dart';
export 'package:uberCloneRider/core/resources/App_Size.dart';
export 'package:uberCloneRider/core/resources/CustomAppText.dart';
export 'package:uberCloneRider/core/resources/customAppIcon.dart';
export 'package:uberCloneRider/core/resources/sizedboxWidget.dart';
export 'package:uberCloneRider/core/routing/route_generator.dart';
export 'package:uberCloneRider/core/routing/routes.dart';
export 'package:uberCloneRider/core/statmanagment/bloc_observer.dart';
export 'package:uberCloneRider/core/widgets/App_TextField.dart';
export 'package:uberCloneRider/core/widgets/CustomContainer.dart';
export 'package:uberCloneRider/core/widgets/CustomServiceWidget.dart';
export 'package:uberCloneRider/core/widgets/DefaultAppBar.dart';
export 'package:uberCloneRider/core/widgets/defaultElevatedButton.dart';
export 'package:uberCloneRider/core/widgets/defaultFloatingActionButton.dart';
export 'package:uberCloneRider/core/widgets/showSnackbar.dart';
export 'package:uberCloneRider/core/widgets/spacing.dart';
export 'package:uberCloneRider/feature/Auth/DomainLayer/Repositoryimpl/Auth_Repository_impl.dart';
export 'package:uberCloneRider/feature/Auth/DomainLayer/UserCases/LoginUser.dart';
export 'package:uberCloneRider/feature/Auth/DomainLayer/UserCases/RegisterUser.dart';
export 'package:uberCloneRider/feature/Auth/DomainLayer/userEntity/AuthEntity.dart';
export 'package:uberCloneRider/feature/Auth/dataLayer/models/Usermodel.dart';
export 'package:uberCloneRider/feature/Auth/dataLayer/repository/AuthRepository.dart';
export 'package:uberCloneRider/feature/Auth/presentation/Cubit/Auth_Cubit.dart';
export 'package:uberCloneRider/feature/Auth/presentation/screens/login_screen.dart';
export 'package:uberCloneRider/feature/Auth/presentation/screens/register_screen.dart';
export 'package:uberCloneRider/feature/LandingPages/screens/landingPage.dart';
// ================== Features ==================
export 'package:uberCloneRider/feature/Location/Location_Controller/Location_Manager.dart';
export 'package:uberCloneRider/feature/NavBar/screens/NavBar.dart';
export 'package:uberCloneRider/feature/NavBar/widgets/CustomButtomNavBar.dart';
export 'package:uberCloneRider/feature/SearchingForDriverScreen/screen/SearchingForDriverScreen.dart';
export 'package:uberCloneRider/feature/Tabs/screens/Myrequests.dart';
export 'package:uberCloneRider/feature/Tabs/screens/home.dart';
export 'package:uberCloneRider/feature/Tabs/screens/profile.dart';
export 'package:uberCloneRider/feature/Tabs/screens/requestCar.dart';
export 'package:uberCloneRider/feature/Tabs/widgets/MyRequestItem.dart';
export 'package:uberCloneRider/feature/Tabs/widgets/Processitem.dart';
export 'package:uberCloneRider/feature/Tabs/widgets/openRouteInGoogleMaps.dart';
export 'package:uberCloneRider/feature/payment/payForTrip.dart';
export 'package:uberCloneRider/feature/TripSummary/TripRepository.dart';
export 'package:uberCloneRider/feature/TripSummary/data/models/tripModel.dart';
export 'package:uberCloneRider/feature/TripSummary/presentation/screen/TripSummaryScreen.dart';
export 'package:uberCloneRider/feature/TripSummary/presentation/widgets/PreviousReportsItem.dart';
export 'package:uberCloneRider/feature/TripSummary/presentation/widgets/TripSummaryDetalis.dart';
export 'package:uberCloneRider/feature/TripSummary/presentation/widgets/Trip_Summary_titleSection.dart';
export 'package:uberCloneRider/core/constant/apiConstant.dart';
export 'package:uberCloneRider/firebase_options.dart';
export 'package:url_launcher/url_launcher.dart';
