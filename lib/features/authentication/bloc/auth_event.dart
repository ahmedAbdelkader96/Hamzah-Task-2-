part of 'auth_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class SignUpEmailPasswordAndCreateAccount extends AuthenticationEvent {
  final UserModel userModel;
  final String password;

  const SignUpEmailPasswordAndCreateAccount(
      {required this.userModel, required this.password});

  @override
  List<Object?> get props => [];
}

class SignInEmailPassword extends AuthenticationEvent {
  final String email;
  final String password;

  const SignInEmailPassword({required this.email, required this.password});

  @override
  List<Object?> get props => [];
}

class SignInGoogle extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class SendOTP extends AuthenticationEvent {
  final String phone;

  const SendOTP({required this.phone});

  @override
  List<Object?> get props => [];
}

class VerifyOTP extends AuthenticationEvent {
  final String phone;
  final String otp;

  const VerifyOTP({required this.phone, required this.otp});

  @override
  List<Object?> get props => [];
}




class SignOut extends AuthenticationEvent {
  final BuildContext context;

  const SignOut({required this.context});


  @override
  List<Object?> get props => [];
}
