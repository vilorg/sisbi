import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardActionButtons extends StatelessWidget {
  const CardActionButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          "assets/icons/action_return.svg",
        ),
        SvgPicture.asset(
          "assets/icons/action_skip.svg",
        ),
        SvgPicture.asset(
          "assets/icons/action_favourite.svg",
        ),
        SvgPicture.asset(
          "assets/icons/action_message.svg",
        ),
        SvgPicture.asset(
          "assets/icons/action_call.svg",
        ),
      ],
    );
  }
}
