import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import '../../../routes/route_names.dart';
import '../view_model/auth_cubit.dart';
import 'widgets/auth_form.dart';
class AuthView extends StatelessWidget {
  const AuthView({super.key, this.signup = false});
  final bool signup;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: AuthForm(
                  signup: signup,
                  onSwitch: () {
                    context.push(signup ? RouteNames.login : RouteNames.signup);
                  },
                  onSuccess: () {
                    if (signup) {
                      context.push(
                        RouteNames.verification,
                        extra: context.read<AuthCubit>().state.draft,
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
