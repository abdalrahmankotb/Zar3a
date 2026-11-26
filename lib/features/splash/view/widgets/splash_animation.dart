import 'package:material_ui/material_ui.dart';

import '../../../../core/widgets/brand_mark.dart';
import '../../../../core/theme/app_colors.dart';

class SplashAnimation extends StatelessWidget {
  const SplashAnimation({super.key, required this.controller});
  final AnimationController controller;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final smallSize = width * .224;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double time = controller.value * 3950;
        double y = height / 2;
        double size = smallSize;
        double opacity = 0;
        // كل if مرحلة واضحة: المنتصف، أسفل، المنتصف، أسفل، الملء.
        if (time < 650) {
          y = height / 2 + height / 2 * Curves.easeInOut.transform(time / 650);
        } else if (time < 1300) {
          y =
              height -
              height / 2 * Curves.easeInOut.transform((time - 650) / 650);
        } else if (time < 1950) {
          y =
              height / 2 +
              height / 2 * Curves.easeInOut.transform((time - 1300) / 650);
        } else {
          y = height;
          double fill = ((time - 1950) / 600).clamp(0.0, 1.0);
          // حجم أكبر من الشاشة يضمن تغطية الزوايا من موضع الكرة أسفلها.
          size =
              smallSize +
              (height + width) * 2 * Curves.easeInOut.transform(fill);
        }
        if (time > 2550) {
          opacity = ((time - 2550) / 500).clamp(0.0, 1.0);
        }
        return Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              left: width / 2 - size / 2,
              top: y - size / 2,
              child: Container(
                width: size,
                height: size,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            if (opacity > 0)
              Positioned.fill(
                child: Opacity(
                  opacity: opacity,
                  child: Container(
                    color: AppColors.background,
                    child: const Center(child: BrandMark()),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
