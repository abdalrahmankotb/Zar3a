
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:zar3a/features/auth/view/widgets/auth_social_row.dart';

import '../view_model/recovery_cubit.dart';
import '../../../core/widgets/app_button.dart';
import 'widgets/auth_field.dart';
import 'widgets/verification_code_fields.dart';
import 'widgets/recovery_header.dart';

class RecoveryView extends StatefulWidget {
  const RecoveryView({super.key});

  @override
  State<RecoveryView> createState() => _RecoveryViewState();
}

class _RecoveryViewState extends State<RecoveryView> {
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmation = TextEditingController();

  String code = '';

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          tooltip: 'رجوع',
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<RecoveryCubit, RecoveryState>(
              builder: (context, state) {
                final cubit = context.read<RecoveryCubit>();

                const buttonTexts = [
                  'متابعة',
                  'متابعة المعاينة',
                  'حفظ في المعاينة',
                  'العودة لتسجيل الدخول',
                ];

                return Column(
                  children: [
                    RecoveryHeader(
                      step: state.step,
                      email: state.email,
                    ),

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
                      text: buttonTexts[state.step],
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
                            break;
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
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
