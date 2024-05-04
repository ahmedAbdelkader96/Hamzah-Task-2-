part of 'main_view_bloc.dart';

abstract class MainViewState extends Equatable {
  const MainViewState();
}

// crud states for all users
class MainViewInitialState extends MainViewState {
  @override
  List<Object> get props => [];
}

class LoadingToFetchCurrentUserDataState extends MainViewState {
  @override
  List<Object> get props => [];
}
class DoneToFetchCurrentUserDataState extends MainViewState {
  final UserModel userModel;
  const DoneToFetchCurrentUserDataState({required this.userModel});
  @override
  List<Object> get props => [];
}
class ErrorToFetchCurrentUserDataState extends MainViewState {
  final String message;

  const ErrorToFetchCurrentUserDataState({required this.message});

  @override
  List<Object> get props => [];
}

