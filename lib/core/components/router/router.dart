import 'package:friends_list/feature/auth/widget/auth_scope.dart';
import 'package:friends_list/feature/auth/widget/auth_sign_up.dart';
import 'package:friends_list/feature/home/friends/widget/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:friends_list/feature/auth/widget/auth_screen.dart';

class AppRouter {
  final router = GoRouter(
    redirect: (context, state) {
      final auth = AuthScope.of(context);
      final hasLogin = auth.hasLogin;
      if (hasLogin) {
        return "/home";
      }
      return "/";
    },
    routes: [
      GoRoute(
        path: "/",
        builder: (context, _) => const AuthScreen(),
      ),
      GoRoute(
        path: "/signUp",
        builder: (context, _) => const AuthSignUp(),
      ),
      GoRoute(
        path: "/home",
        builder: (context, _) => const HomeScreen(),
      )
    ],
  );
}
