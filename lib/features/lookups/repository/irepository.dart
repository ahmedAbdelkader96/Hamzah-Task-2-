

import 'package:task2/features/lookups/models/country_lookups_model.dart';

abstract class ILookupsRepository {

  Future<List<CountryLookupsModel>> fetchCountries();


}
