import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'analytics_service.dart';

class GoogleAnalyticsService implements AnalyticsService {
  static const _channel = MethodChannel('com.pokedex/analytics');
  static const _screenViewEvent = 'screen_view';
  static const _screenNameParam = 'screen_name';

  @override
  Future<void> logEvent(String name, [Map<String, dynamic>? params]) async {
    try {
      await _channel.invokeMethod('logEvent', {
        'name': name,
        'params': params ?? {},
      });
    } on PlatformException catch (e) {
      assert(() {
        debugPrint('[Analytics] Failed to log event "$name": $e');
        return true;
      }());
    }
  }

  @override
  Future<void> logScreenView(String screenName) {
    return logEvent(_screenViewEvent, {_screenNameParam: screenName});
  }
}
