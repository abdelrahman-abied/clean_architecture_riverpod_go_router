import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/constants.dart';
import '../core/utils/cache_helper.dart';
import '../features/login/presentation/provider/login_provider.dart';
import '../features/users/presentation/pages/user_page.dart';

import '../core/utils/constants.dart';
import '../features/login/presentation/pages/login_page.dart';
import '../features/myapp.dart';
import 'global_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreference = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [
      sharePreferencesProvider.overrideWithValue(sharedPreference),
    ],
  );
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}
