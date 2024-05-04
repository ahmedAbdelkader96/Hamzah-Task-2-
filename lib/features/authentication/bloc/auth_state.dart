part of 'auth_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

// crud states for all users
class AuthenticationInitialState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class LoadingToSignUpEmailPasswordAndCreateAccountState extends AuthenticationState {
  @override
  List<Object> get props => [];
}
class DoneToSignUpEmailPasswordAndCreateAccountState extends AuthenticationState {

  @override
  List<Object> get props => [];
}
class ErrorToSignUpEmailPasswordAndCreateAccountState extends AuthenticationState {
  final String message;

  const ErrorToSignUpEmailPasswordAndCreateAccountState({required this.message});

  @override
  List<Object> get props => [];
}




class LoadingToSignInEmailPasswordState extends AuthenticationState {
  @override
  List<Object> get props => [];
}
class DoneToSignInEmailPasswordState extends AuthenticationState {

  @override
  List<Object> get props => [];
}
class ErrorToSignInEmailPasswordState extends AuthenticationState {
  final String message;

  const ErrorToSignInEmailPasswordState({required this.message});

  @override
  List<Object> get props => [];
}




class LoadingToSignInGoogleState extends AuthenticationState {
  @override
  List<Object> get props => [];
}
class DoneToSignInGoogleState extends AuthenticationState {

  @override
  List<Object> get props => [];
}
class ErrorToSignInGoogleState extends AuthenticationState {
  final String message;

  const ErrorToSignInGoogleState({required this.message});

  @override
  List<Object> get props => [];
}




class LoadingToSendOTPState extends AuthenticationState {
  @override
  List<Object> get props => [];
}
class DoneToSendOTPState extends AuthenticationState {
  @override
  List<Object> get props => [];
}
class ErrorToSendOTPState extends AuthenticationState {
  final String message;

  const ErrorToSendOTPState({required this.message});

  @override
  List<Object> get props => [];
}




class LoadingToVerifyOTPState extends AuthenticationState {
  @override
  List<Object> get props => [];
}
class DoneToVerifyOTPState extends AuthenticationState {
  @override
  List<Object> get props => [];
}
class ErrorToVerifyOTPState extends AuthenticationState {
  final String message;

  const ErrorToVerifyOTPState({required this.message});

  @override
  List<Object> get props => [];
}






class LoadingToSignOutState extends AuthenticationState {
  @override
  List<Object> get props => [];
}
class DoneToSignOutState extends AuthenticationState {
  @override
  List<Object> get props => [];
}
class ErrorToSignOutState extends AuthenticationState {
  final String message;

  const ErrorToSignOutState({required this.message});

  @override
  List<Object> get props => [];
}
