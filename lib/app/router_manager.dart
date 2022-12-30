import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///路由管理
class RouterManager {
  late RouteObserver<ModalRoute<void>> _routerObserver;
  RouteObserver<ModalRoute<void>> get routeObserver =>
      getInstance()._routerObserver;

  void subscribe(RouteAware routeAware, BuildContext context) {
    _routerObserver.subscribe(routeAware, ModalRoute.of(context)!);
  }

  void unsubscribe(RouteAware routeAware) {
    _routerObserver.unsubscribe(routeAware);
  }

  late FluroRouter _router;
  static List<RouteConfig>? _configs;
  static RouterManager? _instance;
  static RouterManager getInstance() {
    if (_instance == null) {
      _instance = RouterManager._();
    }
    return _instance!;
  }

  static void init(List<RouteConfig> configs) {
    _configs = configs;
  }

  RouterManager._() {
    _routerObserver = RouteObserver<ModalRoute<void>>();
    _router = FluroRouter();
    _configs?.forEach((config) {
      config.configureRoutes(_router);
    });
  }

  Route<dynamic>? generator(RouteSettings routeSettings) {
    return _router.generator(routeSettings);
  }

  ///根据路由名称跳转路由
  Future<dynamic>? navigateTo(String path,
      {bool replace = false,
      bool clearStack = false,
      bool maintainState = true,
      bool rootNavigator = false,
      TransitionType? transition = TransitionType.cupertino,
      Duration? transitionDuration,
      RouteTransitionsBuilder? transitionBuilder,
      Object? arguments,
      RouteSettings? routeSettings}) {
    if (arguments != null && routeSettings == null) {
      routeSettings = RouteSettings(arguments: arguments);
    }
    return _router.navigateTo(Get.context!, path,
        transition: transition,
        routeSettings: routeSettings,
        transitionBuilder: transitionBuilder,
        transitionDuration: transitionDuration,
        replace: replace,
        maintainState: maintainState,
        rootNavigator: rootNavigator,
        clearStack: clearStack);
  }

  ///在使用fluro的情况下不再需要使用这个方法，这里先注释掉
  // ///返回到指定的页面
  // popUntil(String routeName) {
  //   if (Get.context == null) return null;
  //   return Navigator.of(Get.context!).popUntil(ModalRoute.withName(routeName));
  // }

  ///在使用fluro的情况下不再需要使用这个方法，这里先注释掉
  // ///根据配置的名字跳转新路由，用新路由替换当前路由
  // pushReplacementNamed(String routeName) {
  //   if (Get.context == null) return null;
  //   return Navigator.of(Get.context!).pushReplacementNamed(routeName);
  // }

  /// 返回上一个路由
  pop<T>([T? result]) {
    if (Get.context == null) return;
    return _router.pop(Get.context!, result);
  }
}

abstract class RouteConfig {
  void configureRoutes(FluroRouter router);
}
