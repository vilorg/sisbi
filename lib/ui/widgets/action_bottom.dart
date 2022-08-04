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

class RadioActionButton extends StatelessWidget {
  final RadioData radios;
  const RadioActionButton({
    Key? key,
    required this.radios,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Function(int?) onTap = radios.onTap;
    final List<String> titles = radios.titles;

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

    for (int i = 0; i < titles.length; i++) {
      data.add(_RadioTile(
        title: titles[i],
        groupValue: radios.initValue,
        onTap: onTap,
        value: i,
      ));
    }

    return SizedBox(
      height: titles.length * 60 + 50,
      child: SingleChildScrollView(
        child: Column(
          children: data,
        ),
      ),
    );
  }
}

class _RadioTile extends StatelessWidget {
  const _RadioTile({
    Key? key,
    required this.title,
    required this.onTap,
    required this.value,
    required this.groupValue,
  }) : super(key: key);

  final String title;
  final void Function(int?) onTap;
  final int value;
  final int? groupValue;

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      groupValue: groupValue,
      value: value,
      onChanged: (int? val) {
        onTap(val);
        Navigator.of(context).pop();
      },
    );
  }
}

class CheckActionButton extends StatelessWidget {
  final CheckData checks;
  const CheckActionButton({
    Key? key,
    required this.checks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> titles = checks.titles;
    final List<String> values = checks.initValue;

    return StatefulBuilder(
      builder: (BuildContext context, setState) {
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

        for (int i = 0; i < titles.length; i++) {
          bool value = values.contains(titles[i]);
          data.add(_CheckTile(
            title: titles[i],
            onTap: (bool? val) {
              if (value) {
                values.remove(titles[i]);
              } else {
                values.add(titles[i]);
              }
              setState(() {});
            },
            value: value,
          ));
        }

        data.add(Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(defaultButtonPadding),
                  child: Text(
                    "Сохранить",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                onPressed: () {
                  checks.onTap(values);
                  Navigator.of(context).pop();
                }),
          ),
        ));

        return SizedBox(
          height: checks.titles.length * 60 + 120,
          child: SingleChildScrollView(
            child: Column(
              children: data,
            ),
          ),
        );
      },
    );
  }
}

class _CheckTile extends StatelessWidget {
  const _CheckTile({
    Key? key,
    required this.title,
    required this.onTap,
    required this.value,
  }) : super(key: key);

  final String title;
  final bool? value;
  final Function(bool?) onTap;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      value: value,
      onChanged: onTap,
    );
  }
}

class SwitchActionButton extends StatelessWidget {
  final SwitchData switchs;
  const SwitchActionButton({
    Key? key,
    required this.switchs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> titles = switchs.titles;
    final List<bool> values = switchs.initValue;

    return StatefulBuilder(
      builder: (BuildContext context, setState) {
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

        for (int i = 0; i < titles.length; i++) {
          bool value = values[i];
          data.add(_SwitchTile(
            title: "${value ? "Готов" : "Не готов"} ${titles[i]}",
            onTap: (bool val) {
              values[i] = val;
              setState(() {});
            },
            value: value,
          ));
        }

        data.add(Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(defaultButtonPadding),
                  child: Text(
                    "Сохранить",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                onPressed: () {
                  switchs.onTap(values);
                  Navigator.of(context).pop();
                }),
          ),
        ));

        return SizedBox(
          height: switchs.titles.length * 60 + 120,
          child: SingleChildScrollView(
            child: Column(
              children: data,
            ),
          ),
        );
      },
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    Key? key,
    required this.title,
    required this.onTap,
    required this.value,
  }) : super(key: key);

  final String title;
  final bool value;
  final Function(bool) onTap;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      value: value,
      onChanged: onTap,
    );
  }
}
