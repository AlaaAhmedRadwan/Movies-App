import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/features/home/domain/entities/history_movie.dart';
import 'package:movies_app/features/home/domain/entities/wishlist_movie.dart';

class FirebaseMoviesService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FirebaseMoviesService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  // ─── Private helpers ─────────────────────────────────────────────────────

  String get _userId {
    final uid = _auth.currentUser?.uid;
    if (uid == null) throw Exception('User not authenticated');
    return uid;
  }

  CollectionReference<Map<String, dynamic>> get _wishlistRef =>
      _firestore.collection('users').doc(_userId).collection('wishlist');

  CollectionReference<Map<String, dynamic>> get _historyRef =>
      _firestore.collection('users').doc(_userId).collection('history');

  // ─── Wishlist ─────────────────────────────────────────────────────────────

  /// Adds a movie to the current user's wishlist.
  /// Uses the movie id as the document id to prevent duplicates.
  Future<void> addToWishlist(WishlistMovie movie) async {
    await _wishlistRef.doc(movie.id.toString()).set(movie.toMap());
  }

  /// Removes a movie from the current user's wishlist.
  Future<void> removeFromWishlist(int movieId) async {
    await _wishlistRef.doc(movieId.toString()).delete();
  }

  /// Returns true if the movie is already in the current user's wishlist.
  Future<bool> isMovieInWishlist(int movieId) async {
    final doc = await _wishlistRef.doc(movieId.toString()).get();
    return doc.exists;
  }

  /// Returns a real-time stream of the current user's wishlist.
  Stream<List<WishlistMovie>> getWishlist() {
    return _wishlistRef.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => WishlistMovie.fromMap(doc.data()))
              .toList(),
        );
  }

  // ─── Watch History ────────────────────────────────────────────────────────

  /// Adds a movie to the current user's watch history, stamping the current
  /// time as [watchedAt]. Re-watching a movie updates the existing entry.
  Future<void> addToHistory(HistoryMovie movie) async {
    await _historyRef.doc(movie.id.toString()).set(movie.toMap());
  }

  /// Returns a real-time stream of the current user's watch history,
  /// ordered by [watchedAt] descending (latest first).
  Stream<List<HistoryMovie>> getHistory() {
    return _historyRef
        .orderBy('watchedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => HistoryMovie.fromMap(doc.data()))
              .toList(),
        );
  }
}
