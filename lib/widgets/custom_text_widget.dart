import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String theText;
  final bool? isThisAHeader;
  final bool? isThisASubheader;
  final bool? isThisABody;
  const CustomTextWidget({
    Key? key,
    required this.theText,
    required this.isThisAHeader,
    required this.isThisASubheader,
    required this.isThisABody,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(theText,
        style: isThisABody!
            ? Theme.of(context).textTheme.bodyText2
            : isThisASubheader!
                ? Theme.of(context).textTheme.bodyText1
                : isThisAHeader!
                    ? Theme.of(context).textTheme.headline1
                    : Theme.of(context).textTheme.bodyText2);
  }
}
