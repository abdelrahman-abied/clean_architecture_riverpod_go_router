import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../users/data/models/user_model.dart';

final userDetailsProvider = ChangeNotifierProvider.autoDispose(
  (ref) {
    return UserDetailsProvider();
  },
);

class UserDetailsProvider extends ChangeNotifier {
  bool _editMode = false;
  Users? _currentUser;
  changeEditMode(bool modeValue) {
    _editMode = modeValue;
    notifyListeners();
  }

  changeCurrentUser(Users user) {
    _currentUser = user;
    notifyListeners();
  }

  bool get editMode => _editMode;
  Users? get currentUser => _currentUser;
}
