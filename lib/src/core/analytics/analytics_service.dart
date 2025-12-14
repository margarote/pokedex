abstract class AnalyticsService {
  Future<void> logEvent(String name, [Map<String, dynamic>? params]);
  Future<void> logScreenView(String screenName);
}
