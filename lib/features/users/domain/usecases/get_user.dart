import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/error/failures.dart';

import '../../../../core/usecases/usecase.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_repo_impl.dart';
import '../repositories/users_repository.dart';

final usersUseCaseProvider = Provider(
  (ref) {
    final userRepo = ref.watch(usersRepoImplProvider);
    return GetUsersUseCase(userRepo);
  },
);

class GetUsersUseCase extends UseCase<List<Users>, int> {
  final UsersRepo usersRepo;

  GetUsersUseCase(this.usersRepo);
  @override
  Future<Either<Failure, List<Users>>> call(int limit) =>
      usersRepo.getUsers(limit);
}
