import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uberCloneRider/core/di/service_Locator.dart';
import 'package:uberCloneRider/feature/requestCar/presentation/cubit/request_car_cubit.dart';
import 'package:uberCloneRider/feature/requestCar/presentation/widgets/request_car_view.dart';

class Requestcar extends StatelessWidget {
  const Requestcar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestCarCubit>(
      create: (_) => servicelocator<RequestCarCubit>()..initializeLocation(),
      child: const RequestCarView(),
    );
  }
}
