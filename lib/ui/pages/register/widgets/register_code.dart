import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/ui/pages/register/register_view_model.dart';
import 'package:sisbi/ui/widgets/code_input_fields.dart';

class RegisterCode extends StatefulWidget {
  const RegisterCode({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterCode> createState() => _RegisterCodeState();
}

class _RegisterCodeState extends State<RegisterCode> {
  late Timer _timer;
  bool _isResentAvaible = false;
  bool _isResent = false;
  int _countDown = 120;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countDown == 0) {
        _timer.cancel();
        _isResentAvaible = true;
      } else {
        _countDown -= 1;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var model = context.read<RegisterViewModel>();
    var state = context.select((RegisterViewModel model) => model.state);

    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: SvgPicture.asset(
            "assets/icons/register_spiral_top.svg",
            alignment: Alignment.topRight,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: SvgPicture.asset(
            "assets/icons/register_spiral_bottom.svg",
            alignment: Alignment.bottomLeft,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Введите полученный код из СМС",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        color: colorTextContrast,
                      ),
                ),
                const SizedBox(height: defaultPadding),
                CodeInputFields(
                  isError: state.isCodeError,
                  setSmsValue: model.setSmsValue,
                  validateSmsValue: model.validateSmsValue,
                ),
                GestureDetector(
                  onTap: _isResentAvaible & !_isResent
                      ? () {
                          try {
                            model.resendSmsCode();
                            _isResentAvaible = false;
                            _isResent = true;
                            setState(() {});
                          } catch (e) {
                            model.previousPage();
                          }
                        }
                      : null,
                  child: Text(
                    _isResent
                        ? "Код был повторно выслан"
                        : _isResentAvaible
                            ? "Отправить код снова?"
                            : "Выслать код повторно через ${_countDown ~/ 60}:${_countDown % 60}",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: colorTextContrast,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
