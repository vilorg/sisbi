// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/tile_data.dart';

class ActionButton extends StatelessWidget {
  final List<TileData> tiles;
  const ActionButton({
    Key? key,
    required this.tiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> data = [
      const SizedBox(height: defaultPadding),
      Container(
        width: 50,
        height: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: Colors.grey[300],
        ),
      ),
      const SizedBox(height: defaultPadding / 2),
      const Divider(),
    ];

    for (TileData tile in tiles) {
      data.add(_Tile(tile: tile));
      data.add(const Divider());
    }

    return SizedBox(
      height: tiles.length * 52 + 50,
      child: SingleChildScrollView(
        child: Column(
          children: data,
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    Key? key,
    required this.tile,
  }) : super(key: key);

  final TileData tile;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tile.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tile.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: tile.isRed ? colorAccentRed : colorText),
            ),
            SvgPicture.asset(tile.asset),
          ],
        ),
      ),
    );
  }
}
