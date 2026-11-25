import 'package:material_ui/material_ui.dart';

import '../../../../core/widgets/brand_mark.dart';

class PreferencesHeader extends StatelessWidget {
  const PreferencesHeader({super.key});
  @override
  Widget build(BuildContext context) => const Column(
    children: [
      SizedBox(height: 12),
      BrandMark(showName: false, size: 130),
      SizedBox(height: 15),
      Text(
        'اختر ما يناسبك بشكل أفضل',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
      ),
      SizedBox(height: 14),
      Text(
        'اختر الاهتمامات التي تهمك\nلنقدم لك تجربة مخصصة',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15, height: 1.7),
      ),
      SizedBox(height: 25),
    ],
  );
}
