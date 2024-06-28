import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void navigateTo(String routeName)  {
     GoRouter.of(navigatorKey.currentContext!).go(routeName);
  }

  // static void navigateAndReplace(String routeName)  {
  //    GoRouter.of(navigatorKey.currentContext!).goReplacement(routeName);
  // }
}
