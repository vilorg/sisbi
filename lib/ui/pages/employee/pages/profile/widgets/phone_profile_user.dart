// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';

class _ViewModel extends ChangeNotifier {
  final BuildContext _context;
  _ViewModel(this._context);

  TextEditingController _controller = TextEditingController();
  TextEditingController get controller => _controller;

  bool _isFirst = true;
  bool get isFirst => _isFirst;

  String? _textError;
  String? get textError => _textError;

  void onChanged(String v) {
    notifyListeners();
  }

  void verifyPhone() {
    _isFirst = !isFirst;
    notifyListeners();
  }
}

class PhoneProfileUser extends StatelessWidget {
  const PhoneProfileUser({Key? key}) : super(key: key);

  static Widget create() => ChangeNotifierProvider(
        create: (context) => _ViewModel(context),
        child: const PhoneProfileUser(),
      );

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_ViewModel>(context);
    final bool isFirst = model.isFirst;

    final TextEditingController _controller = model.controller;

    List<Widget> data = [
      Scaffold(
        key: const ValueKey(0),
        backgroundColor: colorAccentDarkBlue,
        appBar: AppBar(
          title: Text(
            "Номер телефона",
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        body: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(borderRadiusPage),
          ),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    cursorColor: colorText,
                    cursorWidth: 1,
                    controller: _controller,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(defaultPadding * 0.8),
                        child: SvgPicture.asset(
                          "assets/icons/login_phone.svg",
                          color: model.textError == null
                              ? colorText
                              : colorInputError,
                        ),
                      ),
                      suffixIcon: _controller.text != ""
                          ? InkWell(
                              onTap: () {
                                _controller.clear();
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(defaultPadding * 0.8),
                                child: SvgPicture.asset(
                                  "assets/icons/login_clear.svg",
                                  color: model.textError == null
                                      ? colorAccentLightBlue
                                      : colorInputError,
                                ),
                              ),
                            )
                          : null,
                      hintText: "+7 │ Номер телефона",
                      errorText: model.textError,
                      errorStyle:
                          Theme.of(context).textTheme.bodyText2!.copyWith(
                                color: colorInputError,
                              ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [phoneMask],
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: model.textError == null
                              ? colorText
                              : colorInputError,
                        ),
                    onChanged: model.onChanged,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(defaultButtonPadding),
                        child: Text(
                          "Продолжить",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                      onPressed: _controller.text.length >= 18
                          ? model.verifyPhone
                          : null,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      WillPopScope(
        onWillPop: () async {
          model.verifyPhone();
          return false;
        },
        key: const ValueKey(1),
        child: Scaffold(
          backgroundColor: colorAccentDarkBlue,
          appBar: AppBar(
            title: Text(
              "Код подтверждения",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: colorTextContrast,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          body: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(borderRadiusPage),
            ),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(defaultButtonPadding),
                          child: Text(
                            "Продолжить",
                            style: Theme.of(context).textTheme.button,
                          ),
                        ),
                        onPressed: _controller.text.length >= 18
                            ? model.verifyPhone
                            : null,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ];

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        final inAnimation = Tween<Offset>(
                begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
            .animate(animation);
        final outAnimation = Tween<Offset>(
                begin: const Offset(-1.0, 0.0), end: const Offset(0.0, 0.0))
            .animate(animation);

        if (child.key == const ValueKey(1)) {
          return ClipRect(
            child: SlideTransition(
              position: isFirst ? outAnimation : inAnimation,
              child: child,
            ),
          );
        } else {
          return ClipRect(
            child: SlideTransition(
              position: isFirst ? inAnimation : outAnimation,
              child: child,
            ),
          );
        }
      },
      child: data[isFirst ? 0 : 1],
    );
  }
}
