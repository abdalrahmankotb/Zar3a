import 'package:material_ui/material_ui.dart';

import '../data/model/intro_selection.dart';

// وجهة معاينة فقط، وليست تسجيل دخول حقيقيا.
class ReadyView extends StatelessWidget {
  const ReadyView({super.key, required this.selection});
  final IntroSelection? selection;
  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      appBar: AppBar(title: const Text('تم الإعداد')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 70),
            const Text(
              'انتهت معاينة شاشات البداية',
              style: TextStyle(fontSize: 22),
            ),
            Text('الاهتمام: ${selection?.label ?? "لم يتم الاختيار"}'),
            Text(
              selection?.location == null
                  ? 'المتابعة بدون موقع'
                  : 'تم تأكيد موقع الجهاز',
            ),
            const Text(
              'هنا اربط شاشة تسجيل الدخول الموجودة في مشروعك. لا يوجد تسجيل دخول فعلي في هذه القطعة.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
