import 'package:flutter/material.dart';
import 'package:sisbi/constants.dart';

class RegisterWrapItemPicker extends StatelessWidget {
  final String text;
  final bool isSelect;
  final VoidCallback onTap;
  const RegisterWrapItemPicker({
    Key? key,
    required this.text,
    required this.isSelect,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding / 4),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: isSelect ? colorAccentLightBlue : colorBorder),
            borderRadius: BorderRadius.circular(100),
            color: isSelect ? colorAccentLightBlue : Colors.transparent,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: defaultPadding / 2,
            horizontal: defaultPadding,
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ),
    );
  }
}
