import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_example/page/list_page1.dart';
import 'package:go_router_example/page/me_page.dart';

import '../common/constant.dart';
import '../page/detail_page.dart';
import '../page/error_page.dart';
import '../page/home_page.dart';
import '../page/login_page.dart';
import 'my_nav_observer.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: home,
      builder: (_, state) => const MyHomePage(title: 'title'),
      routes: [
        GoRoute(
            path: 'list/:id',
            name: list,
            pageBuilder: (_, GoRouterState state) => CustomTransitionPage(
                child: ListPage1(state.pathParameters['id'] ?? ''),
                transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                        Widget child) =>
                    FadeTransition(opacity: animation, child: child))),
      ],
      redirect: loginRedirect,
    ),
    GoRoute(
        path: '/login/:location/:text',
        name: login,
        builder: (context, state) => LoginPage(
              location: state.pathParameters['location'],
              text: state.pathParameters['text'],
            )),
    GoRoute(
      path: '/detail/:id/:ids',
      name: detail,
      builder: (_, GoRouterState state) {
        String? id = state.uri.queryParameters['id'];
        debugPrint(
            'DetailPage idid  ${state.fullPath}  ${state.path}  ${state.matchedLocation}');
        debugPrint(
            'DetailPage name  ${state.name}  ${state.pathParameters}  ${state.uri.queryParameters}');
        return DetailPage(
          id: id,
        );
      },
      // redirect: loginRedirect,
    ),
    GoRoute(
      path: '/me',
      name: me,
      builder: (_, GoRouterState state) => const MePage(),
      // redirect: loginRedirect,
    ),
  ],
  errorBuilder: (context, GoRouterState state) {
    return const ErrorPage();
  },
  debugLogDiagnostics: true,
  observers: [MyNavObserver()],
);

FutureOr<String?> loginRedirect(BuildContext context, GoRouterState state) {
  debugPrint('loginRedirect :${state.name}');

  final loggingIn = state.path == 'login';
  //如果没登录,并且当前不在登录页面,去登录 (并将本来想要跳转的页面传递到登录页)

  if (!Constant.login && !loggingIn) {
    return state.namedLocation(login, pathParameters: {
      'location': state.fullPath!,
      'text': '未登录无法跳转到对应页面',
    });
    //return '/login?location=${state.location}';
  }
  return null;
}

const String login = 'login';
const String home = 'home';
const String list = 'list';
const String detail = 'detail';
const String me = 'me';
