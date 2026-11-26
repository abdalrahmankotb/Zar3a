import 'package:go_router/go_router.dart';
import 'package:zar3a/core/theme/app_colors.dart';
import 'package:zar3a/core/theme/app_text_styles.dart';

import '../../../../routes/route_names.dart';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/auth_cubit.dart';
import '../../../../core/widgets/app_button.dart';
import 'auth_field.dart';
import 'auth_header.dart';
import 'auth_social_row.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    required this.signup,
    required this.onSwitch,
    required this.onSuccess,
  });
  final bool signup;
  final VoidCallback onSwitch, onSuccess;
  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final name = TextEditingController(),
      email = TextEditingController(),
      password = TextEditingController(),
      confirmation = TextEditingController();
  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    confirmation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthCubit, AuthState>(
    builder: (context, state) {
      final cubit = context.read<AuthCubit>();
      return AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthHeader(signup: widget.signup),
            if (widget.signup)
              AuthField(
                label: 'الاسم بالكامل',
                controller: name,
                icon: Icons.person_outline,
                error: state.errors['name'],
                autofillHints: const [AutofillHints.name],
              ),
            AuthField(
              label: 'البريد الإلكتروني',
              controller: email,
              icon: Icons.mail_outline,
              keyboardType: TextInputType.emailAddress,
              error: state.errors['email'],
              autofillHints: const [AutofillHints.email],
            ),
            AuthField(
              label: 'كلمة المرور',
              controller: password,
              icon: Icons.lock_outline,
              password: true,
              visible: state.passwordVisible,
              onToggle: () => cubit.togglePassword(),
              error: state.errors['password'],
              autofillHints: [
                widget.signup
                    ? AutofillHints.newPassword
                    : AutofillHints.password,
              ],
            ),
            if (widget.signup)
              AuthField(
                label: 'تأكيد كلمة المرور',
                controller: confirmation,
                icon: Icons.lock_outline,
                password: true,
                visible: state.confirmVisible,
                onToggle: () => cubit.togglePassword(confirm: true),
                error: state.errors['confirmation'],
              ),
            if (!widget.signup)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(
                  onPressed: () =>
                      context.pushNamed(RouteNames.recovery),
                  child: const Text(
                    'هل نسيت كلمة المرور؟',
                    style: TextStyle(color: Color(0xFF4DA534)),
                  ),
                ),
              ),
            AppButton(
              text: widget.signup ? 'إنشاء الحساب' : 'تسجيل الدخول',
              onPressed: () {
                if (cubit.submit(
                  email: email.text,
                  password: password.text,
                  name: name.text,
                  confirmation: confirmation.text,
                  signup: widget.signup,
                )) {
                  widget.onSuccess();
                }
              },
            ),
            AuthSocialRow(divider: !widget.signup),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  widget.signup ? 'هل لديك حساب بالفعل؟' : 'هل لديك أي حساب؟',
                  style: AppTextStyles.bodyMediumBold,
                ),
                TextButton(
                  onPressed: widget.onSwitch,
                  child: Text(
                    widget.signup ? 'تسجيل الدخول' : 'إنشاء حساب',
                    style: AppTextStyles.bodyMediumBold.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
           
          ],
        ),
      );
    },
  );
}
