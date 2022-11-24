import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/users/data/models/user_model.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../features/users/domain/repositories/users_repository.dart';
import '../../../../global_state.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/netwok_info.dart';
import '../datasources/user_service.dart';

final usersRepoImplProvider = Provider(
  (ref) {
    final networkInfo = ref.watch(networkInfoProvider);
    return UsersRepoImpl(
      networkInfo: networkInfo,
      usersService: UsersServiceImpl(),
    );
  },
);

class UsersRepoImpl extends UsersRepo {
  final NetworkInfo networkInfo;
  final UsersService usersService;

  UsersRepoImpl({required this.networkInfo, required this.usersService});

  @override
  Future<Either<Failure, List<Users>>> getUsers(int page) async {
    {
      bool isConnected = await networkInfo.isConnected;
      if (isConnected) {
        try {
          final users = await usersService.getUsers(page);
          print("========$users");
          return Right(users);
        } on UnauthorizedException {
          return Left(ServerFailure());
        } on ServerException {
          return Left(UnutheriztionFailure());
        }
      } else {
        return Left(NetworkFailure());
      }
    }
  }
}
