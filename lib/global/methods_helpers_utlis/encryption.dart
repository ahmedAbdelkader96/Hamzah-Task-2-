import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as enc;
import 'package:encrypt/encrypt.dart';
import 'package:task2/features/authentication/models/user_model.dart';

class EncryptionUtils {
  static IV iv = IV.fromLength(16);
  static enc.Key key = enc.Key.fromSecureRandom(32);
  static Encrypter encrypter = Encrypter(AES(key));

  static Encrypted encryptAES(UserModel userModel) {
    return encrypter.encrypt(jsonEncode(userModel), iv: iv);
  }

  static UserModel decryptAESFromBase64(String text) {
    final Uint8List encryptedBytesWithSalt = base64Decode(text);
    final Uint8List encryptedBytes = encryptedBytesWithSalt.sublist(
      0,
      encryptedBytesWithSalt.length,
    );
    final String decrypted =
        encrypter.decrypt64(base64Encode(encryptedBytes), iv: iv);
    UserModel userModel =
        UserModel.fromJson(jsonDecode(decrypted) as Map<String, dynamic>);

    return userModel;
  }
}
