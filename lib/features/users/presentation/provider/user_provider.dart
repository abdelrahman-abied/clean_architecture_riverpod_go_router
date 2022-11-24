import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/error/failures.dart';
import '../../../login/presentation/provider/login_provider.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/get_user.dart';

final usersProvider = ChangeNotifierProvider((ref) {
  final usersUseCase = ref.watch(usersUseCaseProvider);
  return UsersProvider(userUseCase: usersUseCase, ref: ref);
});

class UsersProvider extends ChangeNotifier {
  // Initialize the list of users to an empty list
  final Ref ref;
  UsersProvider({
    required this.userUseCase,
    required this.ref,
  });
  List<Users> _activeUsers = [];
  List<Users> _users = [];
  List<Users> _inActiveUsers = [];
  int page = 0;
  bool isLoading = false;
  bool isInternetFailed = false;
  bool isUserAutherized = true;

  final GetUsersUseCase userUseCase;
  getUsers() async {
    page = page += 1;
    isLoading = true;
    notifyListeners();
    final response = await userUseCase(page);

    response.fold((failure) {
      if (failure == UnutheriztionFailure()) {
        isUserAutherized = false;
        _users.clear();
        ref
            .read(userLoginProvider)
            .changeUserAutherization(LoginStatus.unknown);
        isLoading = false;

        notifyListeners();
      } else {
        _users.clear();
        isInternetFailed = true;
        isLoading = false;
        notifyListeners();
      }
    }, (users) {
      _users = List.from(_users)..addAll(users);

      _activeUsers = _users
          .where(
            (user) => user.status == Status.active.name,
          )
          .toList();
      _inActiveUsers = _users
          .where(
            (user) => user.status == Status.inactive.name,
          )
          .toList();
      isLoading = false;
      notifyListeners();
    });
  }

  void updateUser(Users user) {
    _users[_users.indexWhere((element) => element.id == user.id)] = user;
    notifyListeners();
  }

  List<Users> get users => _users;
  List<Users> get activeUsers => _activeUsers;
  List<Users> get inActiveUser => _inActiveUsers;
}
