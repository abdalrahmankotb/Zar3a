import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/feature_scaffold.dart';
import '../../../routes/route_names.dart';
import '../view_model/location_cubit.dart';
import '../view_model/location_state.dart';
import 'widgets/location_content.dart';
import 'widgets/location_confirmation.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});
  @override
  Widget build(BuildContext context) =>
      BlocConsumer<LocationCubit, LocationState>(
        listener: (context, state) async {
          if (state.status == LocationStatus.confirmation) {
            final cubit = context.read<LocationCubit>();
            final accepted = await showLocationConfirmation(
              context,
              state.location!,
            );
            if (cubit.isClosed) return;
            if (accepted == true) {
              cubit.accept();
            } else {
              cubit.reject();
            }
          } else if (state.status == LocationStatus.accepted ||
              state.status == LocationStatus.skipped) {
            Navigator.pushNamed(
              context,
              RouteNames.preferences,
              arguments: state.location,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<LocationCubit>();
          return FeatureScaffold(
            child: LocationContent(
              height: MediaQuery.of(context).size.height - 48,
              busy: state.status == LocationStatus.loading,
              failure: state.failure,
              onDetect: cubit.detect,
              onSkip: cubit.skip,
              onSettings: cubit.openSettings,
            ),
          );
        },
      );
}
