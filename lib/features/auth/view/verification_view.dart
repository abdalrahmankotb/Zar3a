import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/auth_draft.dart';
import '../view_model/verification_cubit.dart';
import '../../../core/widgets/app_button.dart';
import 'widgets/verification_code_fields.dart';
import 'widgets/auth_social_row.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key, this.draft});
  final AuthDraft? draft;
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
              child: BlocBuilder<VerificationCubit, VerificationState>(
                builder: (context, state) {
                  final cubit = context.read<VerificationCubit>();
                  return Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          tooltip: 'رجوع',
                          onPressed: () => Navigator.maybePop(context),
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      ),
                      Image.asset(
                        'assets/photos/verification_mail.png',
                        height: 220,
                        width: 270,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'تحقق من بريدك الإلكتروني',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'هنا يظهر إدخال رمز التحقق المكوّن من 4 أرقام',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        draft?.email ?? 'example@gmail.com',
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(
                          color: Color(0xFF347D1D),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 36),
                      VerificationCodeFields(onChanged: cubit.update),
                      if (state.error != null)
                        Text(
                          state.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 16),
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Text(
                            'لم يتم إرسال الكود؟',
                            style: TextStyle(fontSize: 12),
                          ),
                          TextButton(
                            onPressed: state.seconds == 0
                                ? () {
                                    cubit.resendPreview();
                                   
                                  }
                                : null,
                            child: Text(
                              state.seconds == 0
                                  ? 'إعادة الإرسال'
                                  : 'إعادة الإرسال (00:${state.seconds.toString().padLeft(2, '0')})',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      AppButton(
                        text: 'تأكيد',
                        onPressed: () {
                          if (cubit.check()) {}
                        },
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
