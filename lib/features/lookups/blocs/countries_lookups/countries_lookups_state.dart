part of 'countries_lookups_bloc.dart';

abstract class CountriesLookupsState extends Equatable {
  const CountriesLookupsState();
}

// crud states for all users
class CountriesLookupsInitial
    extends CountriesLookupsState {
  @override
  List<Object> get props => [];
}

class LoadingToFetchCountriesLookupsState extends CountriesLookupsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DoneToFetchCountriesLookupsState extends CountriesLookupsState {
  final List<CountryLookupsModel> countries;


  const DoneToFetchCountriesLookupsState({ required this.countries});
  @override
  List<Object> get props => [];
}

class ErrorToFetchCountriesLookupsState extends CountriesLookupsState {
  final String message;
  const ErrorToFetchCountriesLookupsState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}



