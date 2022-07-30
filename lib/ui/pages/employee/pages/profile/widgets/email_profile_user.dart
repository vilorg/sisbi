// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sisbi/constants.dart';

class EmailProfileUser extends StatefulWidget {
  const EmailProfileUser({
    Key? key,
    required this.initValue,
    required this.setEmail,
  }) : super(key: key);
  final String initValue;
  final Function(String) setEmail;

  @override
  State<EmailProfileUser> createState() => _EmailProfileUserState();
}

class _EmailProfileUserState extends State<EmailProfileUser> {
  TextEditingController controller = TextEditingController();

  bool get isError => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(controller.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAccentDarkBlue,
      appBar: AppBar(
        title: Text(
          "Email-адрес",
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: colorTextContrast,
                fontWeight: FontWeight.w700,
              ),
        ),
        actions: [
          TextButton(
            onPressed: isError
                ? () {
                    widget.setEmail(controller.text);
                    Navigator.of(context).pop();
                  }
                : null,
            child: Text(
              "Сохранить",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: colorTextContrast,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Текущий email-адрес",
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: defaultPadding / 2),
                Text(
                  widget.initValue.isEmpty ? "Не указано" : widget.initValue,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: colorTextSecondary,
                      ),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  cursorColor: colorText,
                  cursorWidth: 1,
                  controller: controller,
                  decoration: InputDecoration(
                    suffixIcon: controller.text != ""
                        ? InkWell(
                            onTap: () => setState(controller.clear),
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(defaultPadding * 0.8),
                              child: SvgPicture.asset(
                                  "assets/icons/login_clear.svg",
                                  color: isError
                                      ? colorAccentLightBlue
                                      : colorInputError),
                            ),
                          )
                        : null,
                    hintText: "example@mail.com",
                    errorText: isError ? null : "",
                    errorStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: colorInputError,
                        ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: isError ? colorText : colorInputError,
                      ),
                  onChanged: (v) => setState(() {}),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    //   WillPopScope(
    //     onWillPop: () async {
    //       model.verifyPhone();
    //       return false;
    //     },
    //     key: const ValueKey(1),
    //     child: Scaffold(
    //       backgroundColor: colorAccentDarkBlue,
    //       appBar: AppBar(
    //         title: Text(
    //           "Код подтверждения",
    //           style: Theme.of(context).textTheme.subtitle1!.copyWith(
    //                 color: colorTextContrast,
    //                 fontWeight: FontWeight.w700,
    //               ),
    //         ),
    //       ),
    //       body: ClipRRect(
    //         borderRadius: const BorderRadius.vertical(
    //           top: Radius.circular(borderRadiusPage),
    //         ),
    //         child: Container(
    //           color: Colors.white,
    //           child: Padding(
    //             padding: const EdgeInsets.all(defaultPadding),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 SizedBox(
    //                   width: double.infinity,
    //                   child: ElevatedButton(
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(defaultButtonPadding),
    //                       child: Text(
    //                         "Продолжить",
    //                         style: Theme.of(context).textTheme.button,
    //                       ),
    //                     ),
    //                     onPressed: _controller.text.length >= 18
    //                         ? model.verifyPhone
    //                         : null,
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // ];

    // return AnimatedSwitcher(
    //   duration: const Duration(milliseconds: 200),
    //   transitionBuilder: (Widget child, Animation<double> animation) {
    //     final inAnimation = Tween<Offset>(
    //             begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
    //         .animate(animation);
    //     final outAnimation = Tween<Offset>(
    //             begin: const Offset(-1.0, 0.0), end: const Offset(0.0, 0.0))
    //         .animate(animation);

    //     if (child.key == const ValueKey(1)) {
    //       return ClipRect(
    //         child: SlideTransition(
    //           position: isFirst ? outAnimation : inAnimation,
    //           child: child,
    //         ),
    //       );
    //     } else {
    //       return ClipRect(
    //         child: SlideTransition(
    //           position: isFirst ? inAnimation : outAnimation,
    //           child: child,
    //         ),
    //       );
    //     }
    //   },
    //   child: data[isFirst ? 0 : 1],
    // );
  }
}
