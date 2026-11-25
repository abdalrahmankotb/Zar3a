import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

class VerificationCodeFields extends StatefulWidget {
  const VerificationCodeFields({super.key, required this.onChanged});
  final ValueChanged<String> onChanged;
  @override
  State<VerificationCodeFields> createState() => _VerificationCodeFieldsState();
}

class _VerificationCodeFieldsState extends State<VerificationCodeFields> {
  final controllers = List.generate(4, (_) => TextEditingController());
  final nodes = List.generate(4, (_) => FocusNode());
  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final n in nodes) {
      n.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.ltr,
    child: Row(
      children: List.generate(
        4,
        (i) => Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: i < 3 ? 8 : 0),
            child: TextField(
              key: ValueKey('otp_$i'),
              controller: controllers[i],
              focusNode: nodes[i],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              maxLength: 4,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                counterText: '',
                contentPadding: const EdgeInsets.symmetric(vertical: 20),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (v) {
                if (v.length > 1) {
                  for (var j = 0; j < 4; j++) {
                    controllers[j].text = j < v.length ? v[j] : '';
                  }
                  nodes[3].requestFocus();
                } else if (v.isNotEmpty && i < 3) {
                  nodes[i + 1].requestFocus();
                } else if (v.isEmpty && i > 0) {
                  nodes[i - 1].requestFocus();
                }
                widget.onChanged(controllers.map((c) => c.text).join());
              },
            ),
          ),
        ),
      ),
    ),
  );
}
