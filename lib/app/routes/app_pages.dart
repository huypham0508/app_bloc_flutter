import 'package:app_bloc_flutter/app/modules/counter/views/counter_view.dart';
import 'package:app_bloc_flutter/app/modules/lo_to/views/lo_to_view.dart';
import 'package:go_router/go_router.dart';

part './app_routes.dart';

class AppRouter {
  static GoRouter returnRouter(bool isAuth) {
    GoRouter router = GoRouter(
      routes: [
        GoRoute(
          name: 'splash',
          path: Routes.SPLASH,
          builder: (context, state) => const CounterView(),
        ),
        GoRoute(
          name: 'loto',
          path: Routes.LOTO,
          builder: (context, state) => const LoToView(),
        ),
      ],
      redirect: (context, state) {
        if (!isAuth) {
          return context.namedLocation(Routes.SPLASH);
        }
        return null;
      },
      // initialLocation: Routes.SPLASH,
    );
    return router;
  }
}
