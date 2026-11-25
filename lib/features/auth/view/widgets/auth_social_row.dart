import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/auth_cubit.dart';

import 'package:material_ui/material_ui.dart';

void showAuthNotice(BuildContext context, String text) => ScaffoldMessenger.of(
  context,
).showSnackBar(SnackBar(content: Text(text, textDirection: TextDirection.rtl)));

class AuthSocialRow extends StatelessWidget {
  const AuthSocialRow({super.key, this.divider = false});
  final bool divider;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      if (divider)
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Text('أو الاستمرار', style: TextStyle(fontSize: 12)),
              ),
              Expanded(child: Divider()),
            ],
          ),
        ),
      Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              tooltip: 'Google',
              onPressed: () => showAuthNotice(
                context,
                context.read<AuthCubit>().previewProvider('Google'),
              ),
              icon: Image.asset(
                'assets/google_logo.png',
                width: 30,
                height: 30,
              ),
            ),
            const SizedBox(width: 14),
            IconButton(
              tooltip: 'Apple',
              onPressed: () => showAuthNotice(
                context,
                context.read<AuthCubit>().previewProvider('Apple'),
              ),
              icon: const Icon(Icons.apple, size: 37, color: Colors.black),
            ),
            const SizedBox(width: 14),
            IconButton(
              tooltip: 'Facebook',
              onPressed: () => showAuthNotice(
                context,
                context.read<AuthCubit>().previewProvider('Facebook'),
              ),
              icon: const Icon(
                Icons.facebook,
                size: 36,
                color: Color(0xFF1877F2),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
