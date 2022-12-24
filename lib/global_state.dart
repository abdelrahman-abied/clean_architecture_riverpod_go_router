import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/router/app_routing.dart';
import '../features/login/presentation/provider/login_provider.dart';
import 'core/network/netwok_info.dart';
import 'core/utils/cache_helper.dart';

final networkCheckerProvider = Provider(
  (ref) => InternetConnectionChecker(),
);
final networkInfoProvider = Provider(
  (ref) {
    final networkChecker = ref.watch(networkCheckerProvider);
    return NetworkInfoImpl(connectionChecker: networkChecker);
  },
);
final sharePreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(),
);

final cacheHelperProvider = Provider<CacheHelper>((ref) {
  final sharedPreferences = ref.watch(sharePreferencesProvider);
  return CacheHelper(sharedPreferences);
});
