import 'package:flutter/material.dart';
import 'package:sisbi/constants.dart';

import 'card_header.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CardHeader(),
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
      );
}
