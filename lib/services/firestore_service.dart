import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miracle_tv/models/program_model.dart';
import 'package:miracle_tv/models/video_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<VideoModel>> fetchVideos() {
    return _db.collection('videos').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return VideoModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Stream<List<ProgramModel>> fetchPrograms() {
    return _db.collection('programs').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProgramModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> addVideo(VideoModel video) async {
    await _db.collection('videos').doc(video.id).set(video.toMap());
  }

  Future<void> updateVideo(VideoModel video) async {
    await _db.collection('videos').doc(video.id).update(video.toMap());
  }

  Future<void> deleteVideo(String videoId) async {
    await _db.collection('videos').doc(videoId).delete();
  }

  Future<void> addProgram(ProgramModel program) async {
    await _db.collection('programs').doc(program.id).set(program.toMap());
  }

  Future<void> updateProgram(ProgramModel program) async {
    await _db.collection('programs').doc(program.id).update(program.toMap());
  }

  Future<void> deleteProgram(String programId) async {
    await _db.collection('programs').doc(programId).delete();
  }

  Future<void> toggleFavorite(String userId, String videoId, bool isFavorite) async {
    final ref = _db.collection('favorites').doc('${userId}_$videoId');
    if (isFavorite) {
      await ref.set({
        'userId': userId,
        'videoId': videoId,
        'addedAt': DateTime.now().toIso8601String(),
      });
    } else {
      await ref.delete();
    }
  }
}
