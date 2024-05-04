

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task2/features/authentication/models/user_model.dart';

abstract class IMainViewRepository {

  Future<User?> fetchCurrentUser();
  Future<UserModel> fetchCurrentUserData({required String userId});
}
