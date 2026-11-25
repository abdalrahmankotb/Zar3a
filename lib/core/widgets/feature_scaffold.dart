import 'package:material_ui/material_ui.dart';

class FeatureScaffold extends StatelessWidget {
  const FeatureScaffold({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(padding: const EdgeInsets.all(22), child: child),
        ),
      ),
    ),
  );
}
