import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'cards_switcher_page.dart';

class CardActionButtons extends StatelessWidget {
  const CardActionButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CardsSwitcherViewModel>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: model.resetLast,
          child: SvgPicture.asset(
            "assets/icons/action_return.svg",
          ),
        ),
        GestureDetector(
          onTap: model.nextCard,
          child: SvgPicture.asset(
            "assets/icons/action_skip.svg",
          ),
        ),
        GestureDetector(
          onTap: model.starVacancy,
          child: SvgPicture.asset(
            "assets/icons/action_favourite.svg",
          ),
        ),
        GestureDetector(
          onTap: model.trySendMessage,
          child: SvgPicture.asset(
            "assets/icons/action_message.svg",
          ),
        ),
        GestureDetector(
          onTap: model.showContacts,
          child: SvgPicture.asset(
            "assets/icons/action_call.svg",
          ),
        ),
      ],
    );
  }
}
