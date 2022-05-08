import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/ui/pages/login/login_page.dart';

class LoginPhoneField extends StatefulWidget {
  final bool isValue;
  final String? textError;
  final LoginViewModel model;
  const LoginPhoneField({
    Key? key,
    required this.isValue,
    required this.textError,
    required this.model,
  }) : super(key: key);

  @override
  State<LoginPhoneField> createState() => _LoginPhoneFieldState();
}

class _LoginPhoneFieldState extends State<LoginPhoneField> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: colorText,
      cursorWidth: 1,
      controller: _controller,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(defaultPadding * 0.8),
          child: SvgPicture.asset(
            "assets/icons/login_phone.svg",
            color: widget.textError == null ? colorText : colorInputError,
          ),
        ),
        suffixIcon: widget.isValue
            ? InkWell(
                onTap: () {
                  widget.model.clearPhone();
                  _controller.clear();
                },
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding * 0.8),
                  child: SvgPicture.asset(
                    "assets/icons/login_clear.svg",
                    color: widget.textError == null
                        ? colorAccentLightBlue
                        : colorInputError,
                  ),
                ),
              )
            : null,
        hintText: "+7  │  Номер телефона",
        errorText: widget.textError,
        errorStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: colorInputError,
            ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [phoneMask],
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            color: widget.textError == null ? colorText : colorInputError,
          ),
      onChanged: widget.model.setPhone,
      onSaved: (v) => widget.model.onSaved(),
    );
  }
}
