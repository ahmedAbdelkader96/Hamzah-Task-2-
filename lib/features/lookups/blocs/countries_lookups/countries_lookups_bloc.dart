import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task2/features/lookups/controller/lookups_controller.dart';
import 'package:task2/features/lookups/models/country_lookups_model.dart';

part 'countries_lookups_event.dart';
part 'countries_lookups_state.dart';

class CountriesLookupsBloc
    extends Bloc<CountriesLookupsEvent, CountriesLookupsState> {
  final LookupsController _lookupsController;

  static CountriesLookupsBloc get(BuildContext context) {
    return BlocProvider.of(context);
  }

  CountriesLookupsBloc(this._lookupsController)
      : super(CountriesLookupsInitial()) {
    on<FetchCountries>((event, emit) async {
      try {
        emit(LoadingToFetchCountriesLookupsState());

        List<CountryLookupsModel> countries =
            await _lookupsController.fetchCountries();

        emit(DoneToFetchCountriesLookupsState(countries: countries));
      } on PostgrestException catch (error) {
        emit(ErrorToFetchCountriesLookupsState(message: error.message));
      }
    });
  }
}
