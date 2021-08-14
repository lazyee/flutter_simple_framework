import 'event_bus_manager.dart';
import 'route_manager.dart';
import 'sp_manager.dart';

class Application {
  static void init(RouteConfig routeConfig) {
    SPManager.getInstance();
    RouteManager.init(routeConfig);
  }

  static EventBusManager get eventBus => EventBusManager.getInstance();
  static RouteManager get router => RouteManager.getInstance();
  static SPManager get sp => SPManager.getInstance();

  // static DioManager get api => ApiManager.instance;
  // static DioManager get imAPi => ApiManager.imInstance;
}
