import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_framework/library.dart';

///事件通知
class EventBusManager {
  Map<_EventTag, StreamSubscription> _subscribeMap = {};
  static EventBusManager? _instance;
  static EventBusManager getInstance() {
    if (_instance == null) {
      _instance = EventBusManager._();
    }
    return _instance!;
  }

  ///发送事件
  void fire(dynamic event) {
    _eventBus.fire(event);
  }

  ///订阅事件
  StreamSubscription<T> subscribe<T>(dynamic tag, ValueChanged<T> callback) {
    StreamSubscription<T> _streamSubscription =
        _eventBus.on<T>().listen((event) {
      callback(event);
    });
    _EventTag eventTag = _EventTag(tag);
    _subscribeMap[eventTag]?.cancel();
    _subscribeMap[eventTag] = _streamSubscription;
    return _streamSubscription;
  }

  ///取消订阅
  void unsubscribe(dynamic tag) {
    List eventTagList =
        _subscribeMap.keys.toList().filter((item) => item.tag == tag);
    eventTagList.forEach((item) {
      _subscribeMap.remove(item)?.cancel();
    });
  }

  late EventBus _eventBus;
  EventBusManager._() {
    _eventBus = EventBus();
  }
}

class _EventTag {
  dynamic tag;
  _EventTag(this.tag);
}
