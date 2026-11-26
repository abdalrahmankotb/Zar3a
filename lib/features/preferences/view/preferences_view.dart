import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zar3a/core/theme/app_colors.dart';

import '../../../routes/route_names.dart';
import '../../../core/widgets/feature_scaffold.dart';
import '../../../core/widgets/app_button.dart';
import '../view_model/preferences_cubit.dart';
import 'widgets/interest_tile.dart';
import 'widgets/preferences_header.dart';

class PreferencesView extends StatelessWidget {
  const PreferencesView({super.key});
  @override
  Widget build(BuildContext context) => BlocBuilder<PreferencesCubit, int>(
    builder: (context, selected) {
      final cubit = context.read<PreferencesCubit>();
      return FeatureScaffold(
        child: Column(
          children: [
            const PreferencesHeader(),
            ...List.generate(
              cubit.interests.length,
              (i) => InterestTile(
                index: i,
                label: cubit.interests[i],
                selected: i == selected,
                onTap: () => cubit.select(i),
              ),
            ),
            const SizedBox(height: 12),
            AppButton(
              text: 'ابدأ الآن',
              color: AppColors.primary,
              onPressed: () => context.pushNamed(RouteNames.login, extra: cubit.finish()),
            ),
          ],
        ),
      );
    },
  );
}
