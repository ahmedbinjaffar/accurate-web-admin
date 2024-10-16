import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageHelper {
  static FirebaseStorageHelper instance = FirebaseStorageHelper();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadUserImage(Uint8List image, String fileName) async {
    Reference ref = _storage.ref().child(fileName);
    UploadTask uploadTask =
        ref.putData(image, SettableMetadata(contentType: 'image/jpeg'));

    TaskSnapshot taskSnapshot = await uploadTask;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

  Future<String> uploadUserImage2(Uint8List image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('uploads/images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    UploadTask uploadTask =
        ref.putData(image, SettableMetadata(contentType: 'image/jpeg'));

    TaskSnapshot taskSnapshot = await uploadTask;
    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }
}
