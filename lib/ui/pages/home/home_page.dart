import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewModel extends ChangeNotifier {}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static String nameRoute = "/";

  static Widget create() => ChangeNotifierProvider(
        create: (context) => ViewModel(),
        child: const HomePage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "OK",
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
