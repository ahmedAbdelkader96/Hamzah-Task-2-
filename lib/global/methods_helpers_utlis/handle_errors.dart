import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class HandleErrors{


 static Future<PostgrestException> handlePostgresException({required PostgrestException error
 })async{

    if(error.code == "401"){
      //Routes.refreshCurrentSessionPage(context: context);
    }

    return error;

  }



 static Future<String> handleGeneralException({required Object error
 })async{

   if( error is SocketException){
     return "Check your Network!";
   }

   return error.toString();

 }


}