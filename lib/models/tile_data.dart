// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

class TileData {
  final String title;
  final String asset;
  final bool isRed;
  final VoidCallback onTap;
  TileData({
    required this.title,
    required this.asset,
    required this.isRed,
    required this.onTap,
  });
}

class RadioData {
  final List<String> titles;
  final Function(int?) onTap;
  final int? initValue;
  RadioData({
    required this.titles,
    required this.onTap,
    this.initValue,
  });
}

class CheckData {
  final List<String> titles;
  final Function(List<String>) onTap;
  final List<String> initValue;
  CheckData({
    required this.titles,
    required this.onTap,
    required this.initValue,
  });
}
