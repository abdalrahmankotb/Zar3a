import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_text_styles.dart';

import '../../data/data_source/device_location_source.dart';
import '../../../../core/widgets/app_button.dart';

class LocationContent extends StatelessWidget {
  const LocationContent({
    super.key,
    required this.height,
    required this.busy,
    required this.failure,
    required this.onDetect,
    required this.onSkip,
    required this.onSettings,
  });
  final double height;
  final bool busy;
  final LocationFailure? failure;
  final VoidCallback onDetect, onSkip, onSettings;
  @override
  Widget build(BuildContext context) => Column(
    children: [
      const SizedBox(height: 15),
      SizedBox(
        height: math.min(340, height * .43),
        width: double.infinity,
        child: Image.asset(
          'assets/photos/intro_4.png',
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      ),
      const SizedBox(height: 22),
      const Text(
        'الوصول إلى موقع الجهاز',
        textAlign: TextAlign.center,
        style: AppTextStyles.button,
      ),
      const SizedBox(height: 16),
      const Text(
        'علشان نقدر نقدملك معلومات زراعية وخدمات مناسبة لموقعك.',
        textAlign: TextAlign.center,
        style: AppTextStyles.button,
      ),
      const SizedBox(height: 34),
      AppButton(
        text: busy ? 'جاري تحديد الموقع...' : 'تأكيد',
        onPressed: busy ? null : onDetect,
        color: const Color(0xFF347D1D),
      ),
      if (busy)
        const Padding(
          padding: EdgeInsets.all(14),
          child: CircularProgressIndicator(),
        ),
      if (failure != null) ...[
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            failure!.message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF9E2929)),
          ),
        ),
        if ((failure!.settings || failure!.services) && !kIsWeb)
          TextButton(onPressed: onSettings, child: const Text('فتح الإعدادات')),
      ],
      TextButton(
        onPressed: busy ? null : onSkip,
        child: const Text('المتابعة بدون موقع'),
      ),
    ],
  );
}
