import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/login/presentation/pages/login_page.dart';
import '../../features/login/presentation/provider/login_provider.dart';
import '../../features/user_details/presentation/pages/user_details.dart';
import '../../features/users/data/models/user_model.dart';
import '../../features/users/presentation/pages/user_page.dart';
import '../constants/constants.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    final router = RouterNotifier(ref);
    return GoRouter(
      debugLogDiagnostics: true,
      refreshListenable: router,
      redirect: router.redirectLogic,
      routes: router._routes,
    );
  },
);

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  RouterNotifier(this._ref);
  FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) {
    final bool loggin = state.subloc == '/login';
    final bool isLogged =
        _ref.watch(userLoginProvider).userStatus == LoginStatus.authenticated;

    if (!isLogged) {
      return loggin ? null : '/login';
    }

    return null;
  }

  List<GoRoute> get _routes => <GoRoute>[
        GoRoute(
          path: '/login',
          name: LoginPage.route,
          builder: (BuildContext context, GoRouterState state) {
            return LoginPage();
          },
        ),
        GoRoute(
          path: '/',
          name: UserPage.route,
          builder: (BuildContext context, GoRouterState state) {
            return UserPage();
          },
        ),
        GoRoute(
          path: '/user-detail',
          name: UserDetails.route,
          builder: (BuildContext context, GoRouterState state) {
            return UserDetails(
              user: state.extra as Users,
            );
          },
        ),
      ];
}
