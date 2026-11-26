import '../model/onboarding_item.dart';

const interests = [
  'زراعة الخضروات والفاكهة',
  'زراعة النباتات المنزلية',
  'زراعة المحاصيل الحقلية',
  'مشاكل وأمراض النباتات',
];
const titles = [
  'الكشف الذكي عن الأمراض',
  'منتجات زراعية آمنة',
  'مجتمع زراعي داعم',
  'الوصول إلى المعرفة الزراعية',
];
const descriptions = [
  'صور نباتك واحصل على تحليل دقيق وسريع لأمراض النباتات.',
  'تصفح واحصل على أفضل المنتجات الزراعية بجودة عالية.',
  'تواصل مع مزارعين ذوي الخبرة وتبادل الخبرات والنصائح.',
  'تعلم أكثر عن رعاية النباتات من مصادر موثوقة وبسيطة.',
];

// مصدر محلي فقط. لا يوجد backend أو استدعاء شبكة هنا.
class OnboardingLocalSource {
  List<OnboardingItem> getItems() => List.generate(
    4,
    (i) => OnboardingItem(
      title: titles[i],
      description: descriptions[i],
      image: 'assets/photos/intro_$i.png',
    ),
  );
}
