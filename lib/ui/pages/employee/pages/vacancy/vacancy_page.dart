import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sisbi/constants.dart';

class _ViewModelState {}

class _ViewModel extends ChangeNotifier {}

class VacancyPage extends StatelessWidget {
  const VacancyPage({Key? key}) : super(key: key);

  static Widget create() => ChangeNotifierProvider(
        create: (context) => _ViewModel(),
        child: const VacancyPage(),
      );

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Row(
        children: [
          TextButton(
            child: Row(
              children: [
                SvgPicture.asset("assets/icons/history_watch.svg"),
                const SizedBox(width: defaultPadding / 2),
                Text(
                  "Открыть историю просмотров",
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: colorTextContrast,
                      ),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {},
        ),
      ],
    );

    return Scaffold(
      backgroundColor: colorAccentDarkBlue,
      appBar: appBar,
      body: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(borderRadius),
        ),
        child: ColoredBox(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Header(
                  headerHeight: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.vertical -
                      appBar.preferredSize.height -
                      60,
                ),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Вакансия опубликована 6 апреля 2022 в Новосибирске',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: colorTextSecondary,
                            ),
                      ),
                      const SizedBox(height: defaultPadding),
                      Text(
                        'Описание вакансии',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: defaultPadding / 2),
                      Text(
                        'Мы применяем алгоритмы машинного обучения к рекомендациям контента. Мы не просто берем готовые решения, но и создаем собственные, пригодные к работе в условиях высоких нагрузок и больших данных. Помимо классического ML, мы используем deep learning и байесовские методы. Типичный пример нашего проекта — система, которая на ходу учится определять перспективность нового контента и аудиторию, среди которой он будет наиболее востребован.\r\n\r\nИщем специалиста, который будет вместе с нами разрабатывать рекомендательную систему, искать возможности для роста и формировать планы по развитию продукта.\r\n\r\nВам предстоит:\r\n\r\n• математически формулировать бизнес-задачи;\r\n\r\n• использовать огромное количество разных данных;\r\n\r\n• создавать гипотезы по улучшению сервиса, внедрять их и проверять работоспособность в офлайне, а в случае удачи искать способы реализации;\r\n\r\n• проводить A/B-тесты и анализировать результаты экспериментов.\r\n\r\nУ нас интересно, потому что вы сможете поработать с разнообразными state-of-the-art решениями в области рекомендательных систем, например:\r\n\r\n• с продвинутыми методами матричной факторизации для извлечения информации из истории просмотров и поиска;\r\n\r\n• построением текстовых эмбеддингов;\r\n\r\n• методами reinforcement learning;\r\n\r\n• SNA-техниками для анализа социального графа;\r\n\r\n• разработками big data и аналитикой поверх стека Apache Spark;\r\n\r\n• product science для инсайтов и генерирования продуктовых гипотез;\r\n\r\n• анализом границ применимости моделей, техниками explanation для понимания работы моделей и их специфик.\r\n\r\nМы ожидаем, что вы:\r\n\r\n• имеете отличную математическую и алгоритмическую подготовку;\r\n\r\n• знаете методы машинного обучения и умеете грамотно их использовать;\r\n\r\n• работали с рекомендательными системами или интересуетесь ими;\r\n\r\n• уверенно владеете Python, Java или Scala, а также любым из диалектов SQL.\r\n\r\nБудет плюсом, если вы:\r\n\r\n• умеете работать с фреймворками big data — Spark, Hadoop;\r\n\r\n• знакомы с байесовскими методами машинного обучения.\r\n\r\nПриглашаем кандидата, который сможет посещать офис в Санкт-Петербурге или работать в гибридном графике. Ждем ваших откликов. Удачи!',
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
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

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
    required this.headerHeight,
  }) : super(key: key);

  final double headerHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: headerHeight,
      decoration: const BoxDecoration(
        color: colorAccentDarkBlue,
      ),
      child: Stack(
        children: [
          Image.asset(
            "assets/images/сard_preview.png",
            fit: BoxFit.cover,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        width: 25,
                      ),
                      const SizedBox(width: defaultPadding / 2),
                      Text(
                        'Рич Фэмили',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              color: colorTextContrast,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    'UI/UX дизайнер',
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: colorTextContrast,
                        ),
                  ),
                  const SizedBox(height: defaultPadding),
                  Text(
                    'от 45 000 до 65 000 руб ',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: colorTextContrast,
                        ),
                  ),
                  const SizedBox(height: defaultPadding),
                  const _WrapCards(),
                  const SizedBox(height: 2 * defaultPadding),
                  const _ActionButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          "assets/icons/action_return.svg",
        ),
        SvgPicture.asset(
          "assets/icons/action_skip.svg",
        ),
        SvgPicture.asset(
          "assets/icons/action_favourite.svg",
        ),
        SvgPicture.asset(
          "assets/icons/action_message.svg",
        ),
        SvgPicture.asset(
          "assets/icons/action_call.svg",
        ),
      ],
    );
  }
}

class _WrapCards extends StatelessWidget {
  const _WrapCards({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      runSpacing: defaultPadding / 2,
      spacing: defaultPadding / 2,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorAccentDarkBlue,
            border: Border.all(
              color: colorAccentDarkBlue,
            ),
            borderRadius: BorderRadius.circular(300),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: defaultPadding / 2,
            horizontal: defaultPadding,
          ),
          child: Text(
            "Опыт от 3 лет",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: colorAccentDarkBlue,
            ),
            borderRadius: BorderRadius.circular(300),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: defaultPadding / 2,
            horizontal: defaultPadding,
          ),
          child: Text(
            "Полный день",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: colorAccentDarkBlue,
            ),
            borderRadius: BorderRadius.circular(300),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: defaultPadding / 2,
            horizontal: defaultPadding,
          ),
          child: Text(
            "Удаленная работа",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: colorAccentDarkBlue,
            ),
            borderRadius: BorderRadius.circular(300),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: defaultPadding / 2,
            horizontal: defaultPadding,
          ),
          child: Text(
            "Любой город",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: colorTextContrast,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }
}
