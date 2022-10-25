// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sisbi/constants.dart';

class ContactsEmployerPage extends StatefulWidget {
  final String initFullName;
  final String initPhone;
  final String initEmail;
  final Function(String, String, String) setContacts;
  const ContactsEmployerPage({
    Key? key,
    required this.initFullName,
    required this.initPhone,
    required this.initEmail,
    required this.setContacts,
  }) : super(key: key);

  @override
  State<ContactsEmployerPage> createState() => _ContactsEmployerPageState();
}

class _ContactsEmployerPageState extends State<ContactsEmployerPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    fullNameController.text = widget.initFullName;
    phoneController.text = widget.initPhone;
    emailController.text = widget.initEmail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isEmailError = !RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text);
    bool isPhoneError = phoneController.text.length != 13;
    bool isFullNameError = fullNameController.text.length < 7;

    void onTap() {
      if (isPhoneError || isEmailError || isFullNameError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: colorAccentRed,
            content: Text(
              "Заполните корректно данные!",
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: colorTextContrast,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        );
        return;
      } else {
        widget.setContacts(fullNameController.text, phoneController.text,
            emailController.text);
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Контактные данные",
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: colorTextContrast,
                fontWeight: FontWeight.w700,
              ),
        ),
        actions: [
          TextButton(
            onPressed: onTap,
            child: Text(
              "Сохранить",
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ],
      ),
      backgroundColor: colorAccentDarkBlue,
      body: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(borderRadiusPage)),
              child: Container(
                padding: const EdgeInsets.all(defaultPadding),
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  children: [
                    TextField(
                      controller: fullNameController,
                      decoration: const InputDecoration(hintText: "ФИО"),
                      style: Theme.of(context).textTheme.bodyText1,
                      onChanged: (s) => setState(() {}),
                    ),
                    const SizedBox(height: defaultPadding),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 58,
                          decoration: BoxDecoration(
                              color: colorInput,
                              borderRadius:
                                  BorderRadius.circular(borderRadius)),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: defaultPadding),
                            SizedBox(
                              height: 58,
                              child: SvgPicture.asset(
                                "assets/icons/login_phone.svg",
                                color: colorText,
                                height: 25,
                              ),
                            ),
                            const SizedBox(width: defaultPadding / 4),
                            SizedBox(
                              height: 58,
                              child: Center(
                                child: Text(
                                  "+7 │ ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: colorText,
                                      ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                cursorColor: colorText,
                                cursorWidth: 1,
                                controller: phoneController,
                                decoration: InputDecoration(
                                  suffixIcon: phoneController.text != ""
                                      ? InkWell(
                                          onTap: () {
                                            phoneController.clear();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(
                                                defaultPadding * 0.8),
                                            child: SvgPicture.asset(
                                                "assets/icons/login_clear.svg",
                                                color: colorAccentLightBlue),
                                          ),
                                        )
                                      : null,
                                  hintText: "Номер телефона",
                                  errorStyle: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        color: colorInputError,
                                      ),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [phoneMask],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: colorText,
                                    ),
                                onChanged: (s) => setState(() {}),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding),
                    TextField(
                      controller: emailController,
                      decoration:
                          const InputDecoration(hintText: "Email-адрес"),
                      style: Theme.of(context).textTheme.bodyText1,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (s) => setState(() {}),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
