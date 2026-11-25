import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../routes/route_names.dart';
import '../view_model/auth_cubit.dart';
import 'widgets/auth_form.dart';
import 'widgets/auth_social_row.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key, this.signup = false});
  final bool signup;
  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: AuthForm(
                signup: signup,
                onSwitch: () => Navigator.pushReplacementNamed(
                  context,
                  signup ? RouteNames.login : RouteNames.signup,
                ),
                onSuccess: () {
                  if (signup) {
                    Navigator.pushNamed(
                      context,
                      RouteNames.verification,
                      arguments: context.read<AuthCubit>().state.draft,
                    );
                  } else {
                    showAuthNotice(
                      context,
                      'البيانات سليمة شكليا. تسجيل الدخول الحقيقي لم يُربط بعد.',
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
