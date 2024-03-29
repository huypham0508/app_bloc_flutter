import 'package:app_bloc_flutter/app/global_bloc/auth/auth_bloc.dart';
import 'package:app_bloc_flutter/app/modules/lo_to/views/lo_to_view.dart';
import 'package:app_bloc_flutter/app/modules/login/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part './app_routes.dart';

class AppRouter {
  static GoRouter returnRouter(GlobalKey<NavigatorState> navigatorKey) {
    GoRouter router = GoRouter(
      navigatorKey: navigatorKey,
      routes: [
        GoRoute(
          name: 'loto',
          path: Routes.LOTO,
          builder: (context, state) => const LoToView(),
        ),
        GoRoute(
          name: 'login',
          path: Routes.LOGIN,
          builder: (context, state) => LoginView(),
        ),
      ],
      redirect: (context, state) async {
        var checkAuth = context.read<AuthBloc>().state.status;
        if (checkAuth == AuthStatus.loginSuccess) {
          return Routes.LOTO;
        }
        return Routes.LOGIN;
      },
    );
    return router;
  }
}
