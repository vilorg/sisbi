import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sisbi/constants.dart';

class CodeInputFields extends StatelessWidget {
  final bool isError;
  final Function(int, String) setSmsValue;
  final VoidCallback validateSmsValue;

  const CodeInputFields({
    Key? key,
    required this.isError,
    required this.setSmsValue,
    required this.validateSmsValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _InputField(
            index: 0,
            isError: isError,
            setSmsValue: setSmsValue,
            validateSmsValue: validateSmsValue,
          ),
          _InputField(
            index: 1,
            isError: isError,
            setSmsValue: setSmsValue,
            validateSmsValue: validateSmsValue,
          ),
          _InputField(
            index: 2,
            isError: isError,
            setSmsValue: setSmsValue,
            validateSmsValue: validateSmsValue,
          ),
          _InputField(
            index: 3,
            isError: isError,
            setSmsValue: setSmsValue,
            validateSmsValue: validateSmsValue,
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final int index;
  final bool isError;
  final Function(int, String) setSmsValue;
  final VoidCallback validateSmsValue;

  const _InputField({
    Key? key,
    required this.index,
    required this.isError,
    required this.setSmsValue,
    required this.validateSmsValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextField(
        autofocus: index == 0 ? true : false,
        decoration: InputDecoration(
          errorText: isError ? "" : null,
          hintText: "0",
          errorStyle: const TextStyle(
            height: 0,
            fontSize: 0,
          ),
        ),
        onChanged: (v) {
          setSmsValue(index, v);
          if (v.length == 1 && index != 3) {
            FocusScope.of(context).nextFocus();
          } else if (v.isEmpty && index != 0) {
            FocusScope.of(context).previousFocus();
          } else if (v.length == 1 && index == 3) {
            validateSmsValue();
          }
        },
        style: Theme.of(context).textTheme.subtitle1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
