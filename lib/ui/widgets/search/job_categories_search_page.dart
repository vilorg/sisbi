// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/list_data_service.dart';
import 'package:sisbi/models/object_id.dart';

import 'search_page.dart';

class _ViewModel extends ChangeNotifier {
  final SearchViewModel model;
  final BuildContext context;

  _ViewModel(this.context, this.model) {
    _selected = model.filter.jobCategory;
    _init();
  }

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  List<ObjectId> _dataList = [];
  List<ObjectId> get dataList => _dataList;

  List<ObjectId> _selected = [];
  List<ObjectId> get selected => _selected;

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
      _dataList = await _service.getJobCategories();
      _isLoaded = true;
      notifyListeners();
    } catch (e) {
      _dataList = [];
      _isLoaded = true;
    }
  }

  void onTap(ObjectId value) {
    for (var i in _selected) {
      if (i.id == value.id) {
        model.setJobCategory(i, true);
        _selected.remove(i);
        notifyListeners();
        return;
      }
    }
    model.setJobCategory(value, false);
    notifyListeners();
  }
}

class JobCategoriesSearchPage extends StatelessWidget {
  const JobCategoriesSearchPage({Key? key}) : super(key: key);

  static Widget create(SearchViewModel model) => ChangeNotifierProvider(
        create: (context) => _ViewModel(context, model),
        child: const JobCategoriesSearchPage(),
      );

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_ViewModel>(context);
    final List<ObjectId> dataList = model.dataList;
    final isLoaded = model.isLoaded;

    return Scaffold(
        backgroundColor: colorAccentDarkBlue,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            "Сфера деятельности",
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadiusPage)),
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
                            bool value = false;

                            for (var i in model.selected) {
                              if (i.id == dataList[index].id) {
                                value = true;
                                break;
                              }
                            }

                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Checkbox(
                                          activeColor: colorAccentDarkBlue,
                                          value: value,
                                          onChanged: (s) => model.onTap(
                                              ObjectId(
                                                  dataList[index].id, text))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      text,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              overflow: TextOverflow.ellipsis),
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      softWrap: true,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                model.onTap(ObjectId(dataList[index].id, text));
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
        ));
  }
}
