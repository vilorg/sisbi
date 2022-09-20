// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/object_id.dart';

class FieldOfActivitySelectPage extends StatelessWidget {
  final Function(ObjectId) setFieldOfActivity;
  final List<ObjectId> fieldsOfActivity;
  const FieldOfActivitySelectPage({
    Key? key,
    required this.setFieldOfActivity,
    required this.fieldsOfActivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ObjectId> dataList = fieldsOfActivity;

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
              Expanded(
                  child: Material(
                color: Colors.transparent,
                child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    var text = dataList[index].value;

                    return ListTile(
                      title: Text(
                        text,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(overflow: TextOverflow.ellipsis),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        softWrap: true,
                      ),
                      onTap: () {
                        setFieldOfActivity(dataList[index]);
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              )),
            ],
          ),
        ));
  }
}
