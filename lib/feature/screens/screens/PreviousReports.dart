import 'package:flutter/material.dart';
import 'package:uber/core/resources/App_Size.dart';
import 'package:uber/core/resources/sizedboxWidget.dart';
import 'package:uber/core/widgets/DefaultAppBar.dart';
import 'package:uber/feature/screens/widgets/PreviousReportsItem.dart';

class Previousreports extends StatelessWidget {
  const Previousreports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(title: 'prevoius reports'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PreviousReportsItem(
                viewbutton: () {},
                width1: appWidth(context) * 0.43,
                width2: appWidth(context) * 0.43,
                tripNumber: '478',
                to: 'cairo',
                from: 'alex',
                textbutton1: 'share',
                textbutton2: 'open',
              ),
              heightSizedbox(10),
              PreviousReportsItem(
                viewbutton: () {},
                width1: appWidth(context) * 0.43,
                width2: appWidth(context) * 0.43,
                tripNumber: '479',
                to: 'sahrm',
                from: 'kafr',
                textbutton1: 'share',
                textbutton2: 'open',
              ),
              heightSizedbox(10),
              PreviousReportsItem(
                width1: appWidth(context),
                width2: appWidth(context) * 0.86,
                tripNumber: '480',
                to: 'asuit',
                from: 'miniah',
                textbutton1: '',
                textbutton2: 'report download',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
