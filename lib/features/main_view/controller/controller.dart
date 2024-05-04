import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task2/features/authentication/models/user_model.dart';
import 'package:task2/features/main_view/repository/repository.dart';

class MainViewController {
  final repo = MainViewRepository();

  Future<User?> fetchCurrentUser() {
    return repo.fetchCurrentUser();
  }

  Future<UserModel> fetchCurrentUserData({required String userId}) {
    return repo.fetchCurrentUserData(userId: userId);
  }
}
