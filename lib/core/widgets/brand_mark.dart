import 'package:material_ui/material_ui.dart';

class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.showName = true, this.size = 280});
  final bool showName;
  final double size;
  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset('assets/photos/logo.png', width: size, height: size),
      if (showName) ...[
        const SizedBox(height: 16),
        const Text(
          'ZAR3A',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: Color(0xFF193F31),
          ),
        ),
      ],
    ],
  );
}
