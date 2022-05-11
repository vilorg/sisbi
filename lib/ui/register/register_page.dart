import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sisbi/constants.dart';

import 'widgets/register_target.dart';
import 'widgets/register_top_info.dart';

class _ViewModel extends ChangeNotifier {}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static Widget create() => ChangeNotifierProvider(
        create: (context) => _ViewModel(),
        child: const RegisterPage(),
      );

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
        return true;
      },
      child: Scaffold(
        backgroundColor: colorAccentDarkBlue,
        body: Stack(
          children: const [
            RegisterTarget(),
            RegisterTopInfo(),
          ],
        ),
      ),
    );
  }
}
