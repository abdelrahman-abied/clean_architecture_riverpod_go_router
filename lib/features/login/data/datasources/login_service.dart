import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:riverpod_go_router/core/api/end_points.dart';
import 'package:riverpod_go_router/core/api/status_code.dart';
import 'package:riverpod_go_router/core/constants/constants.dart';
import 'package:riverpod_go_router/core/utils/cache_helper.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';

abstract class LoginService {
  Future<LoginStatus> userlogin({required String email});
}

class LoginServiceImpl implements LoginService {
  final CacheHelper cacheHelper;
  LoginServiceImpl(this.cacheHelper);
  @override
  Future<LoginStatus> userlogin({required String email}) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndPoints.login),
        headers: {
          "X-API-KEY": "owwn-challenge-22bbdk",
        },
        body: json.encode({"email": email}),
      );
      debugPrint(response.body.toString());
      debugPrint(response.statusCode.toString());
      debugPrint(response.headers.toString());
      if (response.statusCode == StatusCode.ok) {
        saveUserAuth(response);
        return LoginStatus.authenticated;
      } else {
        throw ServerException();
      }
    } on ServerException {
      throw ServerException();
    }
  }

  void saveUserAuth(http.Response response) {
    final userAccessToken = json.decode(response.body)['access_token'] ?? "";
    final refreshToken = json.decode(response.body)['refresh_token'] ?? "";
    cacheHelper
        .savePrefs(key: Constants.userAccessToken, value: userAccessToken)
        .then((value) => print("=======object"));
    cacheHelper.savePrefs(key: Constants.userRefreshToken, value: refreshToken);
  }
}
