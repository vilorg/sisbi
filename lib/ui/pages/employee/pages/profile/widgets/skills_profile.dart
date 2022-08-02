import 'package:flutter/material.dart';
import 'package:sisbi/constants.dart';

class SkillsProfile extends StatefulWidget {
  final String initSkills;
  final Function(List<String>) setSkills;
  const SkillsProfile(
      {Key? key, required this.initSkills, required this.setSkills})
      : super(key: key);

  @override
  State<SkillsProfile> createState() => _SkillsProfileState();
}

class _SkillsProfileState extends State<SkillsProfile> {
  final TextEditingController controller = TextEditingController();
  List<String> skills = [];

  @override
  void initState() {
    skills = widget.initSkills.split(", ");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> data = [];

    for (String skill in skills) {
      data.add(_getWrapCard(skill, () {
        skills.remove(skill);
        setState(() {});
      }));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Навыки",
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: colorTextContrast,
                fontWeight: FontWeight.w700,
              ),
        ),
        actions: [
          TextButton(
            onPressed: _onSavePressed,
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
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: TextField(
                              controller: controller,
                              decoration: const InputDecoration(
                                  hintText: "Напишите свой навык"),
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          const SizedBox(width: defaultPadding),
                          Flexible(
                            flex: 1,
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: defaultButtonPadding),
                                  child: Text(
                                    "Добавить",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                          color: colorTextContrast,
                                        ),
                                  ),
                                ),
                                onPressed: _onAddPressed,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: defaultPadding),
                      Wrap(
                        alignment: WrapAlignment.start,
                        runSpacing: defaultPadding / 2,
                        spacing: defaultPadding / 2,
                        children: data,
                      ),
                      const Divider(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "${skills.length} из 5",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: colorTextSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  VoidCallback? _onAddPressed() {
    if (controller.text.length <= 1 || skills.length >= 5) return null;
    String text = controller.text;
    text = text.replaceAll(" ", "_");
    skills.add(text);
    controller.clear();
    setState(() {});
    return () {};
  }

  VoidCallback _onSavePressed() {
    widget.setSkills(skills);
    Navigator.of(context).pop();
    return () {};
  }

  Widget _getWrapCard(String title, VoidCallback onDelete) => GestureDetector(
        onTap: onDelete,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: defaultPadding / 2,
            horizontal: defaultPadding,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadiusPage),
            color: colorAccentLightBlue,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );
}
