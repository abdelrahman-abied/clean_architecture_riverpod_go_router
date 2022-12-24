import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/network/netwok_info.dart';
import '../../domain/repositories/login_repository.dart';
import '/core/error/failures.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../global_state.dart';
import '../datasources/login_service.dart';

final loginRepoImplProvider = Provider(
  (ref) {
    final networkInfo = ref.watch(networkInfoProvider);
    final cacheHelper = ref.read(cacheHelperProvider);
    return LoginRepoImpl(
      loginService: LoginServiceImpl(cacheHelper),
      networkInfo: networkInfo,
    );
  },
);

class LoginRepoImpl extends LoginRepository {
  final NetworkInfo networkInfo;
  final LoginService loginService;

  LoginRepoImpl({required this.networkInfo, required this.loginService});
  @override
  Future<Either<Failure, LoginStatus>> userLogin(String email) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final userStatus = await loginService.userlogin(email: email);

        return Right(userStatus);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
