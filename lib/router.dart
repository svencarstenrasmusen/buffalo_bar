import 'package:buffalo_bar/data/providers/user_provider.dart';
import 'package:buffalo_bar/screens/loginScreen.dart';
import 'package:buffalo_bar/screens/mainScreen.dart';
import 'package:buffalo_bar/screens/splashScreen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      builder: (context, state) => const Splashscreen(),
      redirect: (context, state) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        if (userProvider.isLoggedIn) {
          return '/main';
        } else {
          return '/login';
        }
      }),
  GoRoute(path: '/main', builder: (context, state) => const MainScreen()),
  GoRoute(path: '/login', builder: (context, state) => const LoginScreen())
]);
