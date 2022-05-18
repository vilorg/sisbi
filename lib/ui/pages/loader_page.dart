import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/auth_service.dart';

class _ViewModel {
  final _authService = AuthService();
  BuildContext context;

  _ViewModel(this.context) {
    _init();
  }

  void _init() async {
    final isUserToken = await _authService.checkAuth();
    if (isUserToken) {
      _goToAppScreen();
    } else {
      _goToLoginScreen();
    }
  }

  void _goToLoginScreen() => Navigator.of(context).pushNamedAndRemoveUntil(
        NameRoutes.login,
        (route) => false,
      );

  void _goToAppScreen() async {
    final bool isUser = await _authService.checkIsUser();
    Navigator.of(context).pushNamedAndRemoveUntil(
      isUser ? NameRoutes.homeEmployee : NameRoutes.homeEmployer,
      (route) => false,
    );
  }
}

class LoaderPage extends StatelessWidget {
  const LoaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  static Widget create() {
    return Provider(
      create: (context) => _ViewModel(context),
      child: const LoaderPage(),
      lazy: false,
    );
  }
}
