import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sisbi/constants.dart';
import 'package:sisbi/models/employer_data_model.dart';
import 'package:sisbi/ui/widgets/select_wrap_card.dart';

import '../profile_employer_page.dart';

class PersonalDataEmployer extends StatelessWidget {
  const PersonalDataEmployer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProfileEmployerViewModel>(context);
    final EmployerDataModel? employerData = model.employerData;

    return Expanded(
      child: ClipRRect(
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(borderRadiusPage)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              SelectWrapCard(
                title: "Описание организации",
                value: employerData!.about != ""
                    ? employerData.about.length > 8
                        ? employerData.about.substring(0, 11) + "..."
                        : employerData.about
                    : null,
                onTap: model.openAboutScreen,
              ),
              SelectWrapCard(
                title: "Данные для входа",
                value: employerData.phone,
              ),
              SelectWrapCard(
                title: "Email-адрес",
                value: employerData.email,
                onTap: model.openEmailScreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
