import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sisbi/constants.dart';

class RegisterTarget extends StatelessWidget {
  final bool isUser;
  final Function(bool) changeIsUser;
  const RegisterTarget({
    Key? key,
    required this.isUser,
    required this.changeIsUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _Header(),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Text(
                "Какая у вас цель?",
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: colorTextContrast,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: defaultPadding),
              _SwitchTargetItem(
                title: "Я ищу работу",
                isSelect: isUser,
                setIndex: () => changeIsUser(true),
              ),
              const SizedBox(height: defaultPadding / 2),
              _SwitchTargetItem(
                title: "Я ищу сотрудников",
                isSelect: !isUser,
                setIndex: () => changeIsUser(false),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SwitchTargetItem extends StatelessWidget {
  final String title;
  final bool isSelect;
  final VoidCallback setIndex;

  const _SwitchTargetItem({
    Key? key,
    required this.title,
    required this.isSelect,
    required this.setIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: setIndex,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: isSelect ? colorInputActive : null,
            border: Border.all(
                color: isSelect ? colorInputActive : colorTextContrast)),
        padding: const EdgeInsets.all(defaultPadding * 1.3),
        child: Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: colorTextContrast, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            isSelect
                ? SvgPicture.asset(
                    "assets/icons/register_done.svg",
                    width: 18,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset("assets/images/register_top_circle.png",
            width: double.infinity),
        Padding(
            padding: const EdgeInsets.only(bottom: 3 * defaultPadding),
            child: Image.asset(
              "assets/images/register_target.png",
              width: MediaQuery.of(context).size.width / 2,
            )),
      ],
    );
  }
}
