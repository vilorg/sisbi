// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/auth_service.dart';

import 'search_page.dart';

class _ViewModel extends ChangeNotifier {
  final SearchViewModel model;
  final BuildContext context;
  final AuthService _service = AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<String> _dataList = [];
  List<String> get dataList => _dataList;

  final TextEditingController controller = TextEditingController();

  _ViewModel(this.context, this.model);

  void onChanged(String s) async {
    _isLoading = true;
    notifyListeners();
    _dataList = await _service.getPosts(s);
    _isLoading = false;
    notifyListeners();
    // if (s == "") {
    //   _dataList = [];
    //   notifyListeners();
    //   return;
    // }
    // _dataList = [s];
    // notifyListeners();
  }

  void onTap(String value) {
    model.setPost(value);
    Navigator.pop(context);
  }
}

class PostSearchPage extends StatelessWidget {
  const PostSearchPage({Key? key}) : super(key: key);

  static Widget create(SearchViewModel model) => ChangeNotifierProvider(
        create: (context) => _ViewModel(context, model),
        child: const PostSearchPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_ViewModel>(context);
    final isLoading = model.isLoading;
    List<String> dataList = model.dataList;
    final TextEditingController controller = model.controller;

    if (dataList.isEmpty) {
      dataList = [
        "Дизайнер",
        "Программист",
        "Маркетолог",
        "Менеджер по персоналу",
      ];
    }

    return Scaffold(
        backgroundColor: colorAccentDarkBlue,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Должность",
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  defaultPadding, 0, defaultPadding, defaultPadding),
              child: SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: controller,
                  cursorColor: colorTextContrast,
                  cursorWidth: 1,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: colorTextContrast,
                      ),
                  onChanged: model.onChanged,
                  decoration: InputDecoration(
                    hintText: "Желаемая должность",
                    hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: colorTextContrast.withOpacity(0.6),
                        ),
                    fillColor: Colors.transparent,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(defaultPadding * 0.8),
                      child: SvgPicture.asset("assets/icons/prefix_search.svg"),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(defaultPadding * 0.8),
                      child: GestureDetector(
                        onTap: () {
                          controller.clear();
                          model.onChanged("");
                        },
                        child: SvgPicture.asset("assets/icons/login_clear.svg"),
                      ),
                    ),
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.focusedBorder,
                  ),
                ),
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
                        child: isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: colorAccentDarkBlue),
                              )
                            : dataList.isEmpty
                                ? Text(
                                    "Ничего не найдено...",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  )
                                : ListView.builder(
                                    itemCount: dataList.length,
                                    itemBuilder: (context, index) {
                                      var text = dataList[index];

                                      return ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      defaultPadding),
                                              child: Container(
                                                width: 10,
                                                height: 10,
                                                color: colorAccentDarkBlue,
                                              ),
                                            ),
                                            const SizedBox(
                                                width: defaultPadding / 2),
                                            Text(
                                              text,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
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
