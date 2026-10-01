import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miracle_tv/core/constants.dart';
import 'package:miracle_tv/models/live_model.dart';
import 'package:miracle_tv/models/program_model.dart';
import 'package:miracle_tv/models/video_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Videos
  Stream<List<VideoModel>> fetchVideos() {
    return _db
        .collection(FirestoreCollections.videos)
        .where('isPublished', isEqualTo: true)
        .orderBy('publishedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => VideoModel.fromMap(doc.data(), doc.id))
          .toList();
    }).handleError((error) {
      print('Error fetching videos: $error');
      return [];
    });
  }

  Future<VideoModel?> getVideoById(String videoId) async {
    try {
      final doc = await _db
          .collection(FirestoreCollections.videos)
          .doc(videoId)
          .get();
      if (doc.exists) {
        return VideoModel.fromMap(doc.data() ?? {}, doc.id);
      }
    } catch (e) {
      print('Error getting video: $e');
    }
    return null;
  }

  Future<void> addVideo(VideoModel video) async {
    try {
      await _db
          .collection(FirestoreCollections.videos)
          .doc(video.id)
          .set(video.toMap());
    } catch (e) {
      throw 'Error adding video: $e';
    }
  }

  Future<void> updateVideo(VideoModel video) async {
    try {
      await _db
          .collection(FirestoreCollections.videos)
          .doc(video.id)
          .update(video.toMap());
    } catch (e) {
      throw 'Error updating video: $e';
    }
  }

  Future<void> deleteVideo(String videoId) async {
    try {
      await _db.collection(FirestoreCollections.videos).doc(videoId).delete();
    } catch (e) {
      throw 'Error deleting video: $e';
    }
  }

  // Programs
  Stream<List<ProgramModel>> fetchPrograms() {
    return _db
        .collection(FirestoreCollections.programs)
        .where('isPublished', isEqualTo: true)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ProgramModel.fromMap(doc.data(), doc.id))
          .toList();
    }).handleError((error) {
      print('Error fetching programs: $error');
      return [];
    });
  }

  Future<void> addProgram(ProgramModel program) async {
    try {
      await _db
          .collection(FirestoreCollections.programs)
          .doc(program.id)
          .set(program.toMap());
    } catch (e) {
      throw 'Error adding program: $e';
    }
  }

  Future<void> updateProgram(ProgramModel program) async {
    try {
      await _db
          .collection(FirestoreCollections.programs)
          .doc(program.id)
          .update(program.toMap());
    } catch (e) {
      throw 'Error updating program: $e';
    }
  }

  Future<void> deleteProgram(String programId) async {
    try {
      await _db
          .collection(FirestoreCollections.programs)
          .doc(programId)
          .delete();
    } catch (e) {
      throw 'Error deleting program: $e';
    }
  }

  // Live
  Stream<LiveModel?> fetchLive() {
    return _db
        .collection(FirestoreCollections.live)
        .doc('current')
        .snapshots()
        .map((doc) {
      if (doc.exists) {
        return LiveModel.fromMap(doc.data() ?? {}, doc.id);
      }
      return null;
    }).handleError((error) {
      print('Error fetching live: $error');
      return null;
    });
  }

  Future<void> updateLive(LiveModel live) async {
    try {
      await _db
          .collection(FirestoreCollections.live)
          .doc(live.id)
          .set(live.toMap());
    } catch (e) {
      throw 'Error updating live: $e';
    }
  }

  // Favorites
  Future<void> addFavorite(String userId, String videoId) async {
    try {
      await _db
          .collection(FirestoreCollections.users)
          .doc(userId)
          .collection('favorites')
          .doc(videoId)
          .set({'videoId': videoId, 'addedAt': DateTime.now().toIso8601String()});
    } catch (e) {
      throw 'Error adding favorite: $e';
    }
  }

  Future<void> removeFavorite(String userId, String videoId) async {
    try {
      await _db
          .collection(FirestoreCollections.users)
          .doc(userId)
          .collection('favorites')
          .doc(videoId)
          .delete();
    } catch (e) {
      throw 'Error removing favorite: $e';
    }
  }

  Stream<List<String>> fetchUserFavorites(String userId) {
    return _db
        .collection(FirestoreCollections.users)
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => doc.id).toList())
        .handleError((error) {
      print('Error fetching favorites: $error');
      return [];
    });
  }

  Future<bool> isFavorite(String userId, String videoId) async {
    try {
      final doc = await _db
          .collection(FirestoreCollections.users)
          .doc(userId)
          .collection('favorites')
          .doc(videoId)
          .get();
      return doc.exists;
    } catch (e) {
      print('Error checking favorite: $e');
      return false;
    }
  }
}
