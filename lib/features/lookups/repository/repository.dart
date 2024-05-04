
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task2/features/lookups/models/country_lookups_model.dart';
import 'package:task2/features/lookups/repository/irepository.dart';
import 'package:task2/global/methods_helpers_utlis/constants.dart';

class LookupsRepository
    implements ILookupsRepository {
  final supabase = Supabase.instance.client;





  @override
  Future<List<CountryLookupsModel>> fetchCountries() async {
    final data = await supabase.from(Constants.countriesLookupTable).select('*');
    return data.map((item) => CountryLookupsModel.fromJson(item)).toList();
  }





}
