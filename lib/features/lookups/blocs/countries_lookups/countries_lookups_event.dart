part of 'countries_lookups_bloc.dart';

abstract class CountriesLookupsEvent extends Equatable {
  const CountriesLookupsEvent();
}

class FetchCountries extends CountriesLookupsEvent {
  const FetchCountries();
  @override
  List<Object?> get props => [];
}
