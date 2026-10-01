import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(String path, String fileName, dynamic bytes) async {
    final ref = _storage.ref().child(path).child(fileName);
    final uploadTask = await ref.putData(bytes as List<int>);
    return await uploadTask.ref.getDownloadURL();
  }
}
