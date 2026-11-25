import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_colors.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    this.password = false,
    this.visible = false,
    this.onToggle,
    this.error,
    this.keyboardType,
    this.autofillHints,
  });
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool password, visible;
  final VoidCallback? onToggle;
  final String? error;
  final TextInputType? keyboardType;
  final List<String>? autofillHints;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          autofillHints: autofillHints,
          obscureText: password && !visible,
          textDirection: keyboardType == TextInputType.emailAddress
              ? TextDirection.ltr
              : null,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            hintText: label,
            errorText: error,
            filled: true,
            fillColor: Colors.white,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 10,
            ),
            prefixIcon: Icon(icon, size: 19, color: Colors.grey),
            suffixIcon: password
                ? IconButton(
                    tooltip: visible
                        ? 'إخفاء كلمة المرور'
                        : 'إظهار كلمة المرور',
                    onPressed: onToggle,
                    icon: Icon(
                      visible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 20,
                      color: Colors.grey,
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: green),
            ),
          ),
        ),
      ],
    ),
  );
}
