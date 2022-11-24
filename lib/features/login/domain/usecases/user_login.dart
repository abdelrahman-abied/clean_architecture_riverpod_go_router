import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/repositories/login_repo_impl.dart';
import '../repositories/login_repository.dart';

final userLoginUseCaseProvider = Provider(
  (ref) {
    final loginRepo = ref.watch(loginRepoImplProvider);
    return UserLoginUseCase(loginRepo);
  },
);

class UserLoginUseCase implements UseCase<LoginStatus, String> {
  final LoginRepository loginRepo;

  UserLoginUseCase(this.loginRepo);

  @override
  Future<Either<Failure, LoginStatus>> call(String email) {
    return loginRepo.userLogin(email);
  }
}
