import 'package:go_router/go_router.dart';
import 'package:zar3a/Feautres/Auth/views/Login.dart';
class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginView(),
      ),
    ],
  );

}
