import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///路由管理
class RouteManager {
  late RouteObserver<ModalRoute<void>> _routeObserver;
  RouteObserver<ModalRoute<void>> get routeObserver =>
      getInstance()._routeObserver;

  void subscribe(RouteAware routeAware, BuildContext context) {
    _routeObserver.subscribe(routeAware, ModalRoute.of(context)!);
  }

  void unsubscribe(RouteAware routeAware) {
    _routeObserver.unsubscribe(routeAware);
  }

  late FluroRouter router;
  static List<RouteConfig>? _configs;
  static RouteManager? _instance;
  static RouteManager getInstance() {
    if (_instance == null) {
      _instance = RouteManager._();
    }
    return _instance!;
  }

  static void init(List<RouteConfig> configs) {
    _configs = configs;
  }

  RouteManager._() {
    _routeObserver = RouteObserver<ModalRoute<void>>();
    router = FluroRouter();
    _configs?.forEach((config) {
      config.configureRoutes(router);
    });
  }

  Route<dynamic>? generator(RouteSettings routeSettings) {
    return router.generator(routeSettings);
  }

  ///根据路由名称跳转路由
  Future<dynamic>? pushNamed(String routeName,
      {Object? arguments,
      TransitionType? transition = TransitionType.cupertino,
      clearStack: false}) {
    if (Get.context == null) return null;
    RouteSettings? settings;
    if (arguments != null) {
      settings = RouteSettings(arguments: arguments);
    }
    return router.navigateTo(Get.context!, routeName,
        transition: transition,
        routeSettings: settings,
        clearStack: clearStack);
  }

  ///返回到指定的页面
  popUntil(String routeName) {
    if (Get.context == null) return null;
    return Navigator.of(Get.context!).popUntil(ModalRoute.withName(routeName));
  }

  ///根据配置的名字跳转新路由，用新路由替换当前路由
  pushReplacementNamed(String routeName) {
    if (Get.context == null) return null;
    return Navigator.of(Get.context!).pushReplacementNamed(routeName);
  }

  /// 返回上一个路由
  pop({Object? result}) {
    if (Get.context == null) return;
    return Navigator.of(Get.context!).pop(result);
  }
}

abstract class RouteConfig {
  void configureRoutes(FluroRouter router);
}
