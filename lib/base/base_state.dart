import 'package:flutter/cupertino.dart';
import 'package:flutter_simple_framework/library.dart';

bool isAppPaused = false;

abstract class BaseState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver, RouteAware {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      isAppPaused = false;
      onResumed();
    } else if (state == AppLifecycleState.paused) {
      isAppPaused = true;
      onPaused();
    }
  }

  @override
  void didChangeDependencies() {
    Application.router.subscribe(this, context);
    super.didChangeDependencies();
  }

  void onResumed() {}

  void onPaused() {}

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    Application.router.unsubscribe(this);
    Application.eventBus.unsubscribe(this);
    super.dispose();
  }
}
