import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppValueListenableProvider<FirstValue, SecondValue>
    extends StatelessWidget {
  const AppValueListenableProvider({
    required this.firstValue,
    required this.secondValue,
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  final ValueListenable<FirstValue> firstValue;
  final ValueListenable<SecondValue> secondValue;
  final Widget? child;
  final Widget Function(BuildContext context, FirstValue firstValue,
      SecondValue secondValue, Widget? child) builder;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<FirstValue>(
      valueListenable: firstValue,
      builder: (_, firstValue, __) => ValueListenableBuilder<SecondValue>(
          valueListenable: secondValue,
          builder: (context, secondValue, __) =>
              builder(context, firstValue, secondValue, child)));
}
