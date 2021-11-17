import 'event_bus_manager.dart';
import 'router_manager.dart';
import 'sp_manager.dart';

class Application {
  static void init(List<RouteConfig> routeConfigs) {
    SPManager.getInstance();
    RouterManager.init(routeConfigs);
  }

  static EventBusManager get eventBus => EventBusManager.getInstance();
  static RouterManager get router => RouterManager.getInstance();
  static SPManager get sp => SPManager.getInstance();

  // static DioManager get api => ApiManager.instance;
  // static DioManager get imAPi => ApiManager.imInstance;
}
