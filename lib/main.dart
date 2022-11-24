import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/constants.dart';
import '../core/utils/cache_helper.dart';
import '../features/login/presentation/provider/login_provider.dart';
import '../features/users/presentation/pages/user_page.dart';

import '../core/utils/constants.dart';
import '../features/login/presentation/pages/login_page.dart';
import '../features/myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
