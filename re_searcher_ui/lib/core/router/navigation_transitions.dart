import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage buildPageWithSlideTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  const begin = Offset(1, 0);
  const end = Offset.zero;
  const curve = Curves.ease;
  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(position: animation.drive(tween), child: child),
  );
}

CustomTransitionPage buildPageWithFadeTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

Page<dynamic> Function(BuildContext, GoRouterState) defaultPageBuilder<T>(
        Widget child) =>
    (BuildContext context, GoRouterState state) {
      return buildPageWithFadeTransition<T>(
        context: context,
        state: state,
        child: child,
      );
    };

typedef WidgetBuilderWithState = Widget Function(GoRouterState state);

Page<dynamic> Function(BuildContext, GoRouterState)
    defaultPageBuilderWithState<T>(WidgetBuilderWithState child) =>
        (BuildContext context, GoRouterState state) {
          return buildPageWithSlideTransition<T>(
            context: context,
            state: state,
            child: child(state),
          );
        };

Page<dynamic> Function(BuildContext, GoRouterState) fadePageBuilder<T>(
        Widget child) =>
    (BuildContext context, GoRouterState state) {
      return buildPageWithFadeTransition<T>(
        context: context,
        state: state,
        child: child,
      );
    };
