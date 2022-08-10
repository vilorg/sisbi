// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/domain/services/profile_user_service.dart';
import 'package:sisbi/models/object_id.dart';

class _ViewModel extends ChangeNotifier {
  final ProfileUserService _service = ProfileUserService();

  _ViewModel() {
    _init();
  }

  List<ObjectId> _cities = [];
  List<ObjectId> get cities => _cities;

  String _search = '';
  String get search => _search;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> _init() async {
    _isLoading = true;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
    _cities = await _service.getCities(search);
    _isLoading = false;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
  }

  Future<void> refresh() async {
    _isLoading = true;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
    _cities = await _service.getCities(_search);
    _isLoading = false;
    try {
      notifyListeners();
    } catch (e) {
      _isLoading = false;
    }
  }

  void onChanged(String s) {
    _search = s;
    refresh();
  }
}

class CityProfilePage extends StatelessWidget {
  const CityProfilePage({
    Key? key,
    required this.initCity,
    required this.setCity,
  }) : super(key: key);
  final ObjectId initCity;
  final Function(ObjectId) setCity;

  static Widget create(ObjectId initValue, Function(ObjectId) setCity) =>
      ChangeNotifierProvider(
        create: (context) => _ViewModel(),
        child: CityProfilePage(initCity: initValue, setCity: setCity),
      );

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_ViewModel>(context);
    final bool isLoading = model.isLoading;
    final List<ObjectId> cities = model.cities;

    return Scaffold(
      backgroundColor: colorAccentDarkBlue,
      appBar: AppBar(
        title: Text(
          "Город",
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: colorTextContrast,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(borderRadiusPage),
        ),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Текущий город",
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: defaultPadding / 4),
                Text(
                  initCity.value.isEmpty ? "Не указано" : initCity.value,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: colorTextSecondary,
                      ),
                ),
                const SizedBox(height: defaultPadding),
                TextFormField(
                  cursorColor: colorText,
                  cursorWidth: 1,
                  decoration:
                      const InputDecoration(hintText: "Название города"),
                  keyboardType: TextInputType.name,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: colorText,
                      ),
                  onChanged: model.onChanged,
                ),
                Expanded(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: colorAccentDarkBlue,
                          ),
                        )
                      : Material(
                          color: Colors.transparent,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: cities.length,
                            itemBuilder: (context, index) => _Tile(
                              city: cities[index],
                              onTap: () {
                                setCity(cities[index]);
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    Key? key,
    required this.city,
    required this.onTap,
  }) : super(key: key);
  final ObjectId city;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(city.value, style: Theme.of(context).textTheme.bodyText1),
    );
  }
}
