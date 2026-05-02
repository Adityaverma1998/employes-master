import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsRemoteDataSource {
  final FirebaseAnalytics _analytics;

  AnalyticsRemoteDataSource(this._analytics);

  Future<void> logEvent(String name, {Map<String, Object?>? parameters}) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  Future<void> setUserId(String? id) async {
    await _analytics.setUserId(id: id);
  }

  Future<void> setUserProperty(String name, String? value) async {
    await _analytics.setUserProperty(name: name, value: value);
  }

  Future<void> setCurrentScreen(String screenName, {String? screenClassOverride}) async {
    await _analytics.logScreenView(screenName: screenName, screenClass: screenClassOverride);
  }

  Future<void> logLogin(String? loginMethod) async {
    await _analytics.logLogin(loginMethod: loginMethod);
  }

  Future<void> logSignUp(String signUpMethod) async {
    await _analytics.logSignUp(signUpMethod: signUpMethod);
  }
}
