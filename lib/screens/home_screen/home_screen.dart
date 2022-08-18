import 'package:flutter/material.dart';
import 'package:smart_home_dashboard/widgets/custom_text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: CustomTextWidget(
                theText: "Home Screen",
                isThisAHeader: true,
                isThisASubheader: false,
                isThisABody: false,
                isThisAButton: false)),
      ),
    );
  }
}
