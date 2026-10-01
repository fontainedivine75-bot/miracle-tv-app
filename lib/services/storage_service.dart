import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(
    String path,
    String fileName,
    List<int> bytes,
  ) async {
    try {
      final ref = _storage.ref().child(path).child(fileName);
      await ref.putData(bytes);
      return await ref.getDownloadURL();
    } catch (e) {
      throw 'Error uploading image: $e';
    }
  }

  Future<void> deleteImage(String path) async {
    try {
      await _storage.ref(path).delete();
    } catch (e) {
      throw 'Error deleting image: $e';
    }
  }
}
