import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task2/features/authentication/models/user_model.dart';
import 'package:task2/features/main_view/controller/controller.dart';
import 'package:task2/global/methods_helpers_utlis/handle_errors.dart';

part 'main_view_event.dart';
part 'main_view_state.dart';

class MainViewBloc extends Bloc<MainViewEvent, MainViewState> {
  final MainViewController mainViewController;

  static MainViewBloc get(BuildContext context) {
    return BlocProvider.of(context);
  }

  MainViewBloc(this.mainViewController) : super(MainViewInitialState()) {






    on<FetchCurrentUserData>((event, emit) async {
      try {
        emit(LoadingToFetchCurrentUserDataState());


        User? user = await mainViewController.fetchCurrentUser();
        UserModel userModel = await mainViewController.fetchCurrentUserData(userId: user!.id);

        emit(DoneToFetchCurrentUserDataState(userModel: userModel));


      } on PostgrestException catch (error) {
        PostgrestException message = await HandleErrors.handlePostgresException( error: error);
        emit(ErrorToFetchCurrentUserDataState(
            message: message.message));
      } catch (error) {
        String message = await HandleErrors.handleGeneralException(error: error);
        emit(ErrorToFetchCurrentUserDataState(message: message));
      }
    });






  }
}
