import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/route_names.dart';
import '../view_model/splash_cubit.dart';
import 'widgets/splash_animation.dart';
import '../../../core/theme/app_colors.dart';

// من درس الحركة: StatefulWidget وAnimationController وAnimatedBuilder.
// نرسم الكرة بـ Container دائري، دون CustomPainter أو معادلات جيب تمام.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    // 650 مللي لكل نزول أو صعود، ثم 600 للملء و500 للظهور و900 للانتظار.
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3950),
    );

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        context.read<SplashCubit>().finish();
      }
    });

    controller.forward();
  }

 

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, bool>(
      listener: (context, finished) {
        if (finished) {
          context.pushReplacementNamed(RouteNames.onboarding);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SplashAnimation(controller: controller),
      ),
    );
  }
}
