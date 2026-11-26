import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_colors.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({super.key, required this.selected});
  final int selected;
  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.ltr,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (i) => Container(
          margin: const EdgeInsets.all(4),
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == selected ? AppColors.primary : AppColors.background,
          ),
        ),
      ),
    ),
  );
}
