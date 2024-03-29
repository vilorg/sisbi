import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sisbi/constants.dart';
import 'package:sisbi/models/vacancy_model.dart';

import 'vacancuies_switcher_view_model.dart';
import 'widgets/vacancy_switcher_header.dart';

class VacancySwitcherCard extends StatelessWidget {
  const VacancySwitcherCard({
    Key? key,
    required this.isFront,
    required this.vacancy,
  }) : super(key: key);

  final bool isFront;
  final VacancyModel vacancy;

  @override
  Widget build(BuildContext context) =>
      isFront ? _buildFrontCard(context) : _buildCard(context);

  Widget _buildFrontCard(BuildContext context) => Builder(builder: (context) {
        final model = Provider.of<VacanciesSwitcherViewModel>(context);
        final position = model.position;
        final isDragging = model.isDragging;
        final milliseconds = isDragging ? 0 : 400;

        final center = MediaQuery.of(context).size.center(Offset.zero);
        final angle = model.angle;
        final rotatedMatrix = Matrix4.identity()
          ..translate(center.dx, center.dy)
          ..rotateZ(-angle / 6)
          ..translate(-center.dx, -center.dy);

        return AnimatedContainer(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: milliseconds),
          transform: rotatedMatrix
            ..translate(position.dx / 2, position.dy / 10),
          child: GestureDetector(
            child: _buildCard(context),
            onPanStart: (details) {
              final model = Provider.of<VacanciesSwitcherViewModel>(context,
                  listen: false);
              model.startPosition(details);
            },
            onPanUpdate: (details) {
              final model = Provider.of<VacanciesSwitcherViewModel>(context,
                  listen: false);
              model.updatePosition(details);
            },
            onPanEnd: (details) {
              final provider = Provider.of<VacanciesSwitcherViewModel>(context,
                  listen: false);
              provider.endPosition();
            },
          ),
        );
      });

  Widget _buildCard(BuildContext context) {
    final date = vacancy.createdAt.toString().substring(0, 10);
    return ClipRRect(
      borderRadius:
          const BorderRadius.vertical(top: Radius.circular(borderRadius)),
      child: ColoredBox(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VacancySwitcherHeader(vacancy: vacancy),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Вакансия опубликована $date в ${vacancy.cityName}',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: colorTextSecondary,
                          ),
                    ),
                    const SizedBox(height: defaultPadding),
                    Text(
                      "Описание вакансии",
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    Text(
                      vacancy.description,
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
