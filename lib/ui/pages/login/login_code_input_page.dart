import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisbi/constants.dart';

class _ViewModel extends ChangeNotifier {
  _ViewModel(this.context, this.phone);

  final BuildContext context;
  final String phone;
}

class LoginCodeInputPage extends StatefulWidget {
  const LoginCodeInputPage({Key? key}) : super(key: key);

  static Widget onCreate(String phone) => ChangeNotifierProvider(
      create: (context) => _ViewModel(context, phone),
      child: const LoginCodeInputPage());

  @override
  State<LoginCodeInputPage> createState() => _LoginCodeInputPageState();
}

class _LoginCodeInputPageState extends State<LoginCodeInputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Подтверждение телефона",
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: colorAccentDarkBlue,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadiusPage)),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Image.asset("assets/images/login_bird.png"),
                const SizedBox(height: defaultPadding),
                Text(
                  "Мы отправили код подтверждения на указанный номер",
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
