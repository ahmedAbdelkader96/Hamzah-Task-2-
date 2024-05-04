import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task2/features/authentication/models/user_model.dart';
import 'package:task2/features/authentication/repository/irepository.dart';
import 'package:task2/global/methods_helpers_utlis/constants.dart';

class AuthRepository implements IAuthRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<AuthResponse> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final AuthResponse res = await supabase.auth.signUp(
      email: email,
      password: password,
    );
    return res;
  }

  @override
  Future<AuthResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return res;
  }

  @override
  Future<UserModel> createAccount({required UserModel userModel}) async {
    final data = await supabase
        .from(Constants.usersTable)
        .insert(userModel.toJson())
        .select();
    return data.map((item) => UserModel.fromJson(item)).toList()[0];
  }

  @override
  Future<bool> checkIfUserAddedBefore({required String userId}) async {
    final data = await supabase
        .from(Constants.usersTable)
        .select()
        .eq(Constants.userIdColumn, userId);
    if (data.isNotEmpty) {
      return true;
    }
    return false;
  }



  @override
  Future<GoogleSignInAccount?> fetchGoogleSignInAccount() async {
    String webClientId = dotenv.env['webClientId'].toString();

    String iosClientId = dotenv.env['iosClientId'].toString();


    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    return googleUser;
  }

  @override
  Future<AuthResponse> signWithGoogleAccount({required GoogleSignInAccount googleUser}) async {

    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Future<void> sendOTP({required String phone}) async {
    await supabase.auth.signInWithOtp(
      phone: phone,
    );
  }



  @override
  Future<AuthResponse> verifyOTP({required String phone , required String otp }) async {
    AuthResponse res =  await supabase.auth.verifyOTP(
      phone: phone,
      token: otp,
      type: OtpType.sms
    );
    return res;
  }


  @override
  Future<void> signOut() async {

    GoogleSignIn googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }
    await supabase.auth.signOut();
  }




  @override
  Future<Session?> getCurrentSession() async {
    final Session? session = supabase.auth.currentSession;

    if(session != null){
      return session;
    }
    return null;
  }



}
