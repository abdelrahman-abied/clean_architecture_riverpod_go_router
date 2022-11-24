import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/api/end_points.dart';
import '../../../../core/api/status_code.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/constants.dart';

import '../../../../core/utils/log.dart';
import '../models/user_model.dart';

abstract class UsersService {
  Future<List<Users>> getUsers(int limit);
}

class UsersServiceImpl extends UsersService {
  @override
  Future<List<Users>> getUsers(int page) async {
    Log.d(page.toString());
    try {
      final token = CacheHelper.getPrefs(key: Constants.userAccessToken);
      final response = await http.get(
          Uri.parse("${ApiEndPoints.users}?limit=10&page=$page"),
          headers: {
            "X-API-KEY": "owwn-challenge-22bbdk",
            'Authorization': 'Bearer $token',
          });
      Log.d(response.body);
      Log.d(response.statusCode.toString());
      if (response.statusCode == StatusCode.ok) {
        final data = json.decode(response.body)["users"] as List;
        final users = List<Users>.from(
          data.map((x) => Users.fromJson(x as Map<String, dynamic>)),
        );

        return users;
      } else if (response.statusCode == StatusCode.unauthorized) {
        CacheHelper.clearPrefs(key: Constants.userAccessToken);
        CacheHelper.clearPrefs(key: Constants.userRefreshToken);
        throw UnauthorizedException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      Log.e(e.toString());
      throw ServerException();
    }
  }
}
