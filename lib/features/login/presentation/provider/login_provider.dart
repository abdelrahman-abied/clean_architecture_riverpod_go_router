import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_go_router/global_state.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../features/login/domain/usecases/user_login.dart';

import '../../../../core/utils/constants.dart';

final userLoginProvider = ChangeNotifierProvider(
  (ref) {
    final userLoginUseCase = ref.watch(userLoginUseCaseProvider);
    final cacheHelper = ref.watch(cacheHelperProvider);
    return LoginProvider(userLoginUseCase, cacheHelper);
  },
);

class LoginProvider extends ChangeNotifier {
  final UserLoginUseCase loginUseCase;
  final CacheHelper cacheHelper;
  late LoginStatus _userStatus;

  LoginProvider(this.loginUseCase, this.cacheHelper) {
    _userStatus =
        cacheHelper.getPrefs(key: Constants.userAccessToken).toString().isEmpty
            ? LoginStatus.unauthenticated
            : LoginStatus.authenticated;
  }

  Future<LoginStatus> login({required String email}) async {
    final response = await loginUseCase.call(email);
    response.fold((failure) {
      _userStatus = LoginStatus.unauthenticated;
      print(_userStatus.toString());

      notifyListeners();
    }, (loginStatus) {
      _userStatus = LoginStatus.authenticated;
      notifyListeners();
    });

    return _userStatus;
  }

  void checkUserStatus() {
    final userToken =
        CacheHelper.getPrefs(key: Constants.userAccessToken) ?? "";
    if (userToken.toString().isEmpty) {
      _userStatus = LoginStatus.unknown;
      notifyListeners();
    } else {
      _userStatus = LoginStatus.authenticated;
      notifyListeners();
    }
  }

  void changeUserAutherization(LoginStatus loginStatus) {
    _userStatus = loginStatus;
    notifyListeners();
  }

  LoginStatus get userStatus => _userStatus;
}
