import 'package:dartz/dartz.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/error/failures.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginStatus>> userLogin(String email);
}
