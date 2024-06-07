import 'package:go_router/go_router.dart';
import 'package:re_searcher_ui/core/router/navigation_transitions.dart';
import 'package:re_searcher_ui/features/chat/ui/chat_screen.dart';
import 'package:re_searcher_ui/features/home/ui/home_screen.dart';

class AppRouter {
  static GoRouter router([String? initialLocation]) => GoRouter(
        routes: [
          GoRoute(
            path: Routes.home,
            pageBuilder: defaultPageBuilder(
              const HomeScreen(),
            ),
          ),
          GoRoute(
            path: Routes.chat,
            pageBuilder: defaultPageBuilder(
              ChatScreen(),
            ),
          ),
        ],
        initialLocation: initialLocation ?? Routes.home,
      );
}

class Routes {
  static const home = '/home';
  static const chat = '/chat';
}
