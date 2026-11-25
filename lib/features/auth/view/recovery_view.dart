import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/recovery_cubit.dart';
import '../../../core/widgets/app_button.dart';
import 'widgets/auth_field.dart';
import 'widgets/auth_social_row.dart';
import 'widgets/verification_code_fields.dart';
import 'widgets/recovery_header.dart';

class RecoveryView extends StatefulWidget {
  const RecoveryView({super.key});
  @override
  State<RecoveryView> createState() => _RecoveryViewState();
}

class _RecoveryViewState extends State<RecoveryView> {
  final email = TextEditingController(),
      password = TextEditingController(),
      confirmation = TextEditingController();
  String code = '';
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmation.dispose();
    super.dispose();
  }

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
              padding: const EdgeInsets.all(20),
              child: BlocBuilder<RecoveryCubit, RecoveryState>(
                builder: (context, state) {
                  final cubit = context.read<RecoveryCubit>();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: IconButton(
                          tooltip: 'رجوع',
                          onPressed: () {
                            if (state.step > 0 && state.step < 3) {
                              cubit.back();
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      ),
                      RecoveryHeader(step: state.step, email: state.email),
                      if (state.step == 0)
                        AuthField(
                          label: 'البريد الإلكتروني',
                          controller: email,
                          icon: Icons.mail_outline,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      if (state.step == 1) ...[
                        VerificationCodeFields(
                          onChanged: (value) => code = value,
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: state.seconds == 0
                              ? () {
                                  cubit.resend();
                                  showAuthNotice(context, cubit.notice);
                                }
                              : null,
                          child: Text(
                            state.seconds == 0
                                ? 'إعادة الإرسال'
                                : 'إعادة الإرسال (00:${state.seconds.toString().padLeft(2, '0')})',
                          ),
                        ),
                      ],
                      if (state.step == 2) ...[
                        AuthField(
                          label: 'كلمة المرور الجديدة',
                          controller: password,
                          icon: Icons.lock_outline,
                          password: true,
                          visible: state.visible,
                          onToggle: () => cubit.toggle(),
                        ),
                        AuthField(
                          label: 'تأكيد كلمة المرور',
                          controller: confirmation,
                          icon: Icons.lock_outline,
                          password: true,
                          visible: state.confirmVisible,
                          onToggle: () => cubit.toggle(confirm: true),
                        ),
                      ],
                      if (state.error != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            state.error!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(height: 12),
                      AppButton(
                        text: [
                          'متابعة',
                          'متابعة المعاينة',
                          'حفظ في المعاينة',
                          'العودة لتسجيل الدخول',
                        ][state.step],
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          switch (state.step) {
                            case 0:
                              cubit.emailNext(email.text);
                              break;
                            case 1:
                              cubit.codeNext(code);
                              break;
                            case 2:
                              if (cubit.save(
                                password.text,
                                confirmation.text,
                              )) {
                                password.clear();
                                confirmation.clear();
                              }
                              break;
                            case 3:
                              Navigator.pop(context);
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        cubit.notice,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'لا تدخل كلمة مرور أو رمز حساب حقيقي للتجربة.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
