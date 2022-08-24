import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppValueListenableProvider<A, B> extends StatelessWidget {
  const AppValueListenableProvider({
    required this.appRoomsProvider,
    required this.appDevicesProvider,
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  final ValueListenable<A> appRoomsProvider;
  final ValueListenable<B> appDevicesProvider;
  final Widget? child;
  final Widget Function(BuildContext context, A rooms, B devices, Widget? child)
      builder;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<A>(
      valueListenable: appRoomsProvider,
      builder: (_, rooms, __) => ValueListenableBuilder<B>(
          valueListenable: appDevicesProvider,
          builder: (context, devices, __) =>
              builder(context, rooms, devices, child)));
}
