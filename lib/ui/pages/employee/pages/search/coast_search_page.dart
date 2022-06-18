// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/ui/pages/employee/pages/search/search_vacancy_page.dart';

class _ViewModel extends ChangeNotifier {
  final SearchViewModel model;
  final BuildContext context;

  final List<int> _dataList = [
    15000,
    20000,
    25000,
    50000,
    80000,
    100000,
    150000,
  ];
  List<int> get dataList => _dataList;

  _ViewModel(this.context, this.model);

  void onTap(int value) {
    model.setCoast(value);
    Navigator.pop(context);
  }
}

class CoastSearchPage extends StatelessWidget {
  const CoastSearchPage({Key? key}) : super(key: key);

  static Widget create(SearchViewModel model) => ChangeNotifierProvider(
        create: (context) => _ViewModel(context, model),
        child: const CoastSearchPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_ViewModel>(context);
    final List<int> dataList = model.dataList;

    return Scaffold(
        backgroundColor: colorAccentDarkBlue,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Регион",
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
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
                        "Рекомендуемые значения",
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
                            var text =
                                "${dataList[index].toString().substring(0, dataList[index].toString().length - 3)} ${dataList[index].toString().substring(dataList[index].toString().length - 3)} руб.";

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
                                model.onTap(dataList[index]);
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
