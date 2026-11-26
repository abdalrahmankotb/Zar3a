import 'dart:math' as math;

import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/route_names.dart';
import '../../../core/widgets/feature_scaffold.dart';
import '../view_model/onboarding_cubit.dart';
import 'widgets/onboarding_illustration.dart';
import 'widgets/onboarding_copy.dart';
import 'widgets/page_indicator.dart';
import 'widgets/onboarding_actions.dart';

// الشاشة تعرض الحالة وتربط الضغط بالـ Cubit. التنقل أثر واجهة، وليس Widget داخل Cubit.
class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) => BlocBuilder<OnboardingCubit, int>(
    builder: (context, page) {
      final cubit = context.read<OnboardingCubit>();
      final item = cubit.items[page];
      final height = MediaQuery.of(context).size.height - 48;
      return FeatureScaffold(
        child: Column(
          children: [
            SizedBox(height: math.max(8, height * .035)),
            OnboardingIllustration(
              image: item.image,
              height: math.min(330, height * .43),
            ),
            const SizedBox(height: 22),
            OnboardingCopy(title: item.title, description: item.description),
            const SizedBox(height: 42),
            PageIndicator(selected: page),
            const SizedBox(height: 20),
            OnboardingActions(
              onNext: () {
                if (cubit.isLast) {
                  context.pushNamed(RouteNames.location, );
                } else {
                  cubit.next();
                }
              },
              onSkip: () => context.pushNamed(RouteNames.location),
            ),
          ],
        ),
      );
    },
  );
}
