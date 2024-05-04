import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task2/features/authentication/models/user_model.dart';
import 'package:task2/features/authentication/repository/repository.dart';

class AuthController {
  final repo = AuthRepository();

  Future<AuthResponse> signUpWithEmailAndPassword(
      {required String email, required String password}) {
    return repo.signUpWithEmailAndPassword(email: email, password: password);
  }

  Future<AuthResponse> signInWithEmailAndPassword(
      {required String email, required String password}) {
    return repo.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserModel> createAccount({required UserModel userModel}) {
    return repo.createAccount(userModel: userModel);
  }


  Future<bool> checkIfUserAddedBefore({required String userId}){
    return repo.checkIfUserAddedBefore(userId: userId);
  }




  Future<GoogleSignInAccount?> fetchGoogleSignInAccount(){
    return repo.fetchGoogleSignInAccount();
  }
  Future<AuthResponse> signWithGoogleAccount({required GoogleSignInAccount googleUser}){
    return repo.signWithGoogleAccount(googleUser: googleUser);
  }


  Future<void> sendOTP({required String phone}){
    return repo.sendOTP(phone: phone);
  }

  Future<AuthResponse> verifyOTP({required String phone , required String otp }){
    return repo.verifyOTP(phone: phone,otp:otp );

  }


  Future<void> signOut(){
    return repo.signOut();
  }




  Future<Session?> getCurrentSession(){
    return repo.getCurrentSession();
  }
}
