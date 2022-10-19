// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/ui/widgets/search/search_page.dart';

// class _ViewModel extends ChangeNotifier {
//   final SearchViewModel model;

//   final BuildContext context;

//   // final List<int> _dataList = [
//   //   15000,
//   //   20000,
//   //   25000,
//   //   50000,
//   //   80000,
//   //   100000,
//   //   150000,
//   // ];
//   // List<int> get dataList => _dataList;

//   _ViewModel(this.context, this.model);

//   void onTap(int value) {
//     model.setCoast(value);
//     Navigator.pop(context);
//   }
// }

class CoastSearchPage extends StatefulWidget {
  final SearchViewModel model;
  const CoastSearchPage({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<CoastSearchPage> createState() => _CoastSearchPageState();
}

class _CoastSearchPageState extends State<CoastSearchPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> dataList = [
      "15 000",
      "20 000",
      "25 000",
      "50 000",
      "80 000",
      "100 000",
      "150 000",
    ];
    return Scaffold(
        backgroundColor: colorAccentDarkBlue,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Зарплата",
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w700,
                ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                int? num = int.tryParse(controller.text);
                if (num != null) {
                  widget.model.setCoast(num);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: colorAccentRed,
                      content: Text(
                        "Введите корректное значение!",
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: colorTextContrast,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  );
                }
              },
              child: Text(
                "Сохранить",
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration:
                        const InputDecoration(hintText: "Желаемая зарплата"),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(borderRadiusPage)),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                      child: Text(
                        "Рекомендуемые вакансии",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: ListView.builder(
                          itemCount: dataList.length,
                          itemBuilder: (context, index) {
                            var text = dataList[index];

                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(defaultPadding),
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      color: colorAccentDarkBlue,
                                    ),
                                  ),
                                  const SizedBox(width: defaultPadding / 2),
                                  Text(
                                    text,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                              onTap: () {
                                widget.model.setCoast(
                                    int.parse(text.replaceAll(" ", "")));
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
