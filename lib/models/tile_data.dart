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
