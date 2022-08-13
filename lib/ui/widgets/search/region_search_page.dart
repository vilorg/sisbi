// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/list_data_service.dart';
import 'package:sisbi/models/object_id.dart';

import 'search_page.dart';

class _ViewModel extends ChangeNotifier {
  final SearchViewModel model;
  final BuildContext context;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  List<ObjectId> _dataList = [];
  List<ObjectId> get dataList => _dataList;

  final TextEditingController controller = TextEditingController();

  _ViewModel(this.context, this.model) {
    _init();
  }

  final ListDataService _service = ListDataService();

  void onChanged(String s) async {
    _isLoaded = false;
    notifyListeners();
    _dataList = await _service.getCities(s);
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> _init() async {
    try {
      _dataList = await _service.getCities("");
      _isLoaded = true;
      notifyListeners();
    } catch (e) {
      _isLoaded = true;
    }
  }

  void onTap(ObjectId value) {
    model.setRegion(value);
    Navigator.pop(context);
  }
}

class RegionSearchPage extends StatelessWidget {
  const RegionSearchPage({Key? key}) : super(key: key);

  static Widget create(SearchViewModel model) => ChangeNotifierProvider(
        create: (context) => _ViewModel(context, model),
        child: const RegionSearchPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_ViewModel>(context);
    final List<ObjectId> dataList = model.dataList;
    final TextEditingController controller = model.controller;
    final isLoaded = model.isLoaded;

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
                    hintText: "Россия",
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
                        "Рекомендуемые запросы",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    Expanded(
                      child: isLoaded
                          ? Material(
                              color: Colors.transparent,
                              child: ListView.builder(
                                itemCount: dataList.length,
                                itemBuilder: (context, index) {
                                  var text = dataList[index].value;
                                  if (text.length > 20) {
                                    var arr = text.split(" ");
                                    if (arr[arr.length - 3] == "г.") {
                                      text =
                                          "${arr[arr.length - 3]} ${arr[arr.length - 2]} ${arr[arr.length - 1]}";
                                    } else {
                                      text =
                                          "${arr[arr.length - 2]} ${arr[arr.length - 1]}";
                                    }
                                  }
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
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
                                      model.onTap(
                                          ObjectId(dataList[index].id, text));
                                    },
                                  );
                                },
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                  color: colorAccentDarkBlue)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
