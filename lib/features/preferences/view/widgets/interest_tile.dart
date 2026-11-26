import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_colors.dart';

class InterestTile extends StatelessWidget {
  const InterestTile({
    super.key,
    required this.index,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final int index;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Semantics(
      selected: selected,
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(

          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary : AppColors.background,
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.text,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                selected ? Icons.check_circle : Icons.radio_button_unchecked,
                size: 23,
                color: selected ? AppColors.background : Colors.black54,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(label, style: const TextStyle(fontSize: 14)),
              ),
              const SizedBox(width: 8),
              Image.asset('assets/photos/interest_$index.png', width: 26, height: 26),
            ],
          ),
        ),
      ),
    ),
  );
}
