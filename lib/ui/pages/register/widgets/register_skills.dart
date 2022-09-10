import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/ui/pages/register/register_view_model.dart';

import 'register_wrap_item_picker.dart';

class RegisterSkills extends StatelessWidget {
  const RegisterSkills({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<RegisterViewModel>(context);
    var state = model.state;
    final bool isLoading = model.isLoading;
    final bool isSelected = model.isSelected;
    final List<String> posts = model.posts;
    final TextEditingController controller = model.postController;

    int selectedExperience = state.experience;

    List<Widget> data = [];

    if (isLoading) {
      data.add(const Center(
          child: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: CircularProgressIndicator(color: colorIconContrast),
      )));
    } else {
      if (isSelected) {
        for (String post in posts) {
          data.add(
            ColoredBox(
              color: colorAccentDarkBlue,
              child: ListTile(
                title: Text(
                  post,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: colorTextContrast),
                ),
                onTap: () => model.setSkills(post),
              ),
            ),
          );
        }
      }
    }
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
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 3 * defaultPadding,
              bottom: 7 * defaultPadding,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Ваша профессия",
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: colorTextContrast,
                          ),
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  GestureDetector(
                    onTap: model.onSkillsTap,
                    child: TextField(
                      enabled: isSelected,
                      cursorColor: colorText,
                      cursorWidth: 1,
                      decoration: const InputDecoration(
                        hintText: "Должность",
                      ),
                      keyboardType: TextInputType.name,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: colorText,
                          ),
                      controller: controller,
                      onChanged: model.updatePosts,
                    ),
                  ),
                  const SizedBox(height: defaultPadding / 4),
                  ...data,
                  const SizedBox(height: defaultPadding),
                  Text(
                    "Опыт работы",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: colorTextContrast,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      RegisterWrapItemPicker(
                        text: "Нет опыта",
                        isSelect: selectedExperience == 0,
                        onTap: () => model.setExperience(0),
                      ),
                      RegisterWrapItemPicker(
                        text: "1 - 3 года",
                        isSelect: selectedExperience == 1,
                        onTap: () => model.setExperience(1),
                      ),
                      RegisterWrapItemPicker(
                        text: "3 - 6 лет",
                        isSelect: selectedExperience == 2,
                        onTap: () => model.setExperience(2),
                      ),
                      RegisterWrapItemPicker(
                        text: "более 6 лет",
                        isSelect: selectedExperience == 3,
                        onTap: () => model.setExperience(3),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
