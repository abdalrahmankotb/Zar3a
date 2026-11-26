import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/model/selected_location.dart';

Future<bool?> showLocationConfirmation(
  BuildContext context,
  IntroLocation location,
) => showDialog<bool>(
  context: context,
  builder: (ctx) => Directionality(
    textDirection: TextDirection.rtl,
    child: AlertDialog(
      title: const Text('هل تستخدم هذا الموقع؟'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('الموقع الذي أعاده جهازك الآن:'),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              '${location.latitude.toStringAsFixed(5)}, ${location.longitude.toStringAsFixed(5)}',
            ),
          ),
          Text('الدقة التقريبية: ${location.accuracy.round()} متر'),
          const Text(
            'لا نرسل موقعك لخادم ولا نتابعه في الخلفية. الإحداثيات ليست عنوان توصيل.',
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: const Text('لا، أعد المحاولة'),
        ),
        FilledButton(
          onPressed: () => context.pop(true),
          child: const Text('استخدم هذا الموقع'),
        ),
      ],
    ),
  ),
);
