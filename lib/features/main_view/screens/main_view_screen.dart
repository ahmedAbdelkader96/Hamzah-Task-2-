import 'dart:developer';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/features/authentication/bloc/auth_bloc.dart';
import 'package:task2/features/authentication/models/user_model.dart';
import 'package:task2/features/main_view/bloc/main_view_bloc.dart';
import 'package:task2/global/methods_helpers_utlis/encryption.dart';
import 'package:task2/global/methods_helpers_utlis/local_storage_helper.dart';
import 'package:task2/global/methods_helpers_utlis/media_query.dart';
import 'package:task2/global/methods_helpers_utlis/toast.dart';
import 'package:task2/global/navigation_routes/routes.dart';
import 'package:task2/global/widgets/general_raw_material_button.dart';

class MainViewScreen extends StatefulWidget {
  const MainViewScreen({super.key});

  @override
  State<MainViewScreen> createState() => _MainViewScreenState();
}

class _MainViewScreenState extends State<MainViewScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MainViewBloc>().add(FetchCurrentUserData());
  }




  String encryptedBytes = "";
  String encryptedBase16 = "";
  String encryptedBase64 = "";
  bool isEncrypted = false;
  UserModel? decryptedUserModel ;
  bool isLoading = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton:
            BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is ErrorToSignOutState) {
              ToastClass.toast(
                  context: context, data: state.message, seconds: 3);
              log(state.message);
            }

            if (state is DoneToSignOutState) {
              ToastClass.toast(context: context, data: "Signed Out", seconds: 3);
            }
          },
          builder: (context, state) {
            return GeneralRawMaterialButton(
                onPressed: () {
                  if (state is LoadingToVerifyOTPState) {
                  } else {
                    context.read<AuthenticationBloc>().add(SignOut(context: context));
                  }
                },
                height: 56,
                width: MQuery.getWidth(context, 328),
                backColor: Colors.indigo,
                borderSideWidth: 1,
                borderSideColor: const Color(0xFFFFFFFF),
                radius: MQuery.getheight(context, 10),
                child: state is LoadingToSignOutState
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Sign Out",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFFFFFFF)),
                      ));
          },
        ),
        body: Column(
          children: [
            SizedBox(
              height: MQuery.getheight(context, 40),
            ),
            Expanded(
              child: BlocConsumer<MainViewBloc, MainViewState>(
                listener: (context, state) {
                  if (state is ErrorToFetchCurrentUserDataState) {
                    ToastClass.toast(
                        context: context, data: state.message, seconds: 3);
                    log(state.message);
                  }
                },
                builder: (context, state) {
                  if (state is DoneToFetchCurrentUserDataState) {
                    return ListView(
                      padding: EdgeInsets.only(
                          left: MQuery.getWidth(context, 16),
                          right: MQuery.getWidth(context, 16)),
                      children: [
                        SizedBox(
                          height: MQuery.getheight(context, 10),
                        ),
                       Card(
                         color: Colors.white,
                         shadowColor: Colors.grey,
                         elevation: 5,

                         child:  Padding(
                             padding: const EdgeInsets.all(12.0),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 const Text(
                                   "Current User Data",
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                       fontSize: 18,
                                       fontWeight: FontWeight.w700,
                                       color: Colors.black),
                                 ),
                                 SizedBox(
                                   height: MQuery.getheight(context, 15),
                                 ),
                                 Text(
                                   "User Id : ${state.userModel.userId}",textAlign: TextAlign.center,
                                 ),
                                 const SizedBox(height: 5,),
                                 Text(
                                   "User name : ${state.userModel.name}",textAlign: TextAlign.center,
                                 ),
                                 const SizedBox(height: 5,),
                                 Text(
                                   "User email : ${state.userModel.email}",textAlign: TextAlign.center,
                                 ),
                                 const SizedBox(height: 5,),
                                 Text(
                                   "User phone : ${state.userModel.phone}",textAlign: TextAlign.center,
                                 ),
                                 const SizedBox(height: 5,),
                                 Text(
                                   "User job Title : ${state.userModel.jobTitle}",textAlign: TextAlign.center,
                                 ),
                               ],
                             ),
                           ),
                       ),
                        const SizedBox(height: 20),


                        ElevatedButton(
                            onPressed: () async {

                              setState(() {
                                isLoading = true;
                              });

                              if(isEncrypted){
                                encryptedBytes = "";
                                encryptedBase16 = "";
                                encryptedBase64 = "";
                                String? encryptedUserAsBase64 = await LocalStorageHelper.getString(
                                    "encryptedUserModel");
                                decryptedUserModel =  EncryptionUtils.decryptAESFromBase64(encryptedUserAsBase64!);
                                await LocalStorageHelper.remove("encryptedUserModel");
                                isEncrypted = false;


                              }else{
                                Encrypted encrypted = EncryptionUtils.encryptAES(state.userModel);
                                await LocalStorageHelper.setString(
                                    "encryptedUserModel", encrypted.base64);
                                encryptedBytes = encrypted.bytes.toString();
                                encryptedBase16 = encrypted.base16.toString();
                                encryptedBase64 = encrypted.base64.toString();
                                decryptedUserModel = null;
                                isEncrypted = true;
                              }




                              setState(() {
                                isLoading = false;
                              });

                            },
                            child: isLoading? const CircularProgressIndicator(): Text(isEncrypted ? "Decrypt":"Encrypt User Data")),
                        const SizedBox(height: 20),


                        const Text("User Data : ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),

                        Text(decryptedUserModel != null ? decryptedUserModel!.toJson().toString() : "",),
                        const SizedBox(height: 10,),


                        const Text("Encrypted Bytes : ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                        Text(encryptedBytes),
                        const SizedBox(height: 10,),


                        const Text("Encrypted Base16 : ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                        Text(encryptedBase16),
                        const SizedBox(height: 10,),


                        const Text("Encrypted Base64 : ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                        Text(encryptedBase64),
                        const SizedBox(height: 10,),

                        SizedBox(height: MQuery.getheight(context, 120),),

                      ],
                    );
                  }

                  if (state is ErrorToFetchCurrentUserDataState) {
                    return Text(state.message);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
