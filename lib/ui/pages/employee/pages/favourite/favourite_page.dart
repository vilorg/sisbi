import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _ViewModel extends ChangeNotifier {}

class FavouritePage extends StatelessWidget {
  const FavouritePage({Key? key}) : super(key: key);

  static Widget create() => ChangeNotifierProvider(
        create: (context) => _ViewModel(),
        child: const FavouritePage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
