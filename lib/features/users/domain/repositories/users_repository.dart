import 'package:dartz/dartz.dart';
import '../../../../features/users/data/models/user_model.dart';
import '../../../../core/error/failures.dart';

abstract class UsersRepo {
  Future<Either<Failure, List<Users>>> getUsers(int page);
}
