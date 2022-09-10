// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sisbi/constants.dart';

class CodeInputFields extends StatefulWidget {
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
  State<CodeInputFields> createState() => _CodeInputFieldsState();
}

class _CodeInputFieldsState extends State<CodeInputFields> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final TextEditingController _thirdController = TextEditingController();
  final TextEditingController _fourthController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final VoidCallback onTap = () {
      _firstController.text = "";
      _secondController.text = "";
      _thirdController.text = "";
      _fourthController.text = "";
      widget.setSmsValue(0, "");
      widget.setSmsValue(1, "");
      widget.setSmsValue(2, "");
      widget.setSmsValue(3, "");
      focusNode.requestFocus();
      setState(() {});
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding * 2),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _InputField(
              controller: _firstController,
              index: 0,
              isError: widget.isError,
              setSmsValue: widget.setSmsValue,
              validateSmsValue: widget.validateSmsValue,
              focus: focusNode,
              onTap: onTap,
            ),
            _InputField(
              controller: _secondController,
              index: 1,
              isError: widget.isError,
              setSmsValue: widget.setSmsValue,
              validateSmsValue: widget.validateSmsValue,
              onTap: onTap,
            ),
            _InputField(
              controller: _thirdController,
              index: 2,
              isError: widget.isError,
              setSmsValue: widget.setSmsValue,
              validateSmsValue: widget.validateSmsValue,
              onTap: onTap,
            ),
            _InputField(
              controller: _fourthController,
              index: 3,
              isError: widget.isError,
              setSmsValue: widget.setSmsValue,
              validateSmsValue: widget.validateSmsValue,
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final int index;
  final bool isError;
  final Function(int, String) setSmsValue;
  final VoidCallback validateSmsValue;
  final TextEditingController controller;
  final FocusNode? focus;
  final VoidCallback onTap;

  const _InputField({
    Key? key,
    required this.index,
    required this.isError,
    required this.setSmsValue,
    required this.validateSmsValue,
    required this.controller,
    this.focus,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextField(
        focusNode: focus,
        controller: controller,
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
        onTap: onTap,
      ),
    );
  }
}
