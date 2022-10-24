import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:omdb_movies_app/home/home.dart';
import 'package:uuid/uuid.dart';

class FirestoreRepository {
  FirestoreRepository() : _firestore = FirebaseFirestore.instance {
    _usersRef = _firestore.collection('users').withConverter<AppUser>(
          fromFirestore: (snapshot, options) =>
              AppUser.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
    _listsRef = _firestore.collection('lists').withConverter<MovieList>(
          fromFirestore: (snapshot, options) =>
              MovieList.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }
  final FirebaseFirestore _firestore;
  late CollectionReference _usersRef;
  late CollectionReference<MovieList> _listsRef;

  Stream<QuerySnapshot<MovieList>> get publicLists => _listsRef
      .where(
        'private',
        isEqualTo: false,
      )
      .withConverter<MovieList>(
        fromFirestore: (s, __) => MovieList.fromJson(s.data()!),
        toFirestore: (v, _) => v.toJson(),
      )
      .snapshots();

  Stream<QuerySnapshot<MovieList>> getPrivateLists(List<String> listIDs) =>
      _listsRef.where('listID', whereIn: listIDs).snapshots();

  Stream<QuerySnapshot<MovieList>> userLists(AppUser user) {
    return _listsRef
        .where(
          'listID',
          whereIn:
              [...user.privateLists, ...user.publicLists].take(10).toList(),
        )
        .snapshots();
  }

  Future<MovieList?> getList(String listID) {
    return _listsRef
        .doc(listID)
        .withConverter<MovieList>(
          fromFirestore: (snapshot, options) =>
              MovieList.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .get()
        .then((snap) => snap.data());
  }

  Future<AppUser> getAppUser(String userID) {
    return _usersRef
        .doc(userID)
        .withConverter<AppUser>(
          fromFirestore: (snapshot, options) =>
              AppUser.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        )
        .get()
        .then(
          (snapshot) => snapshot.data()!,
        );
  }

  Future<void> createUser(String userId) async {
    await _usersRef.doc(userId).set(const AppUser());
  }

  Future<void> createList({
    required MovieList movieList,
    required String userId,
    required AppUser user,
  }) async {
    final listID = const Uuid().v4();
    return _listsRef.doc(listID).set(movieList.copyWith(listID: listID)).then(
          (_) async => await _usersRef.doc(userId).update({
            if (movieList.private)
              'private_lists': FieldValue.arrayUnion([listID])
            else
              'public_lists': FieldValue.arrayUnion([listID])
          }),
        );
  }

  Future<void> deleteList({
    required MovieList movieList,
    required AppUser user,
    required String userID,
  }) async =>
      _listsRef.doc(movieList.listID).delete().then((_) async {
        if (movieList.private) {
          _usersRef.doc(userID).update(
                user
                    .copyWith(
                      privateLists: [...user.privateLists]
                        ..remove(movieList.listID),
                    )
                    .toJson(),
              );
        } else {
          _usersRef.doc(userID).update(
                user
                    .copyWith(
                      publicLists: [...user.publicLists]
                        ..remove(movieList.listID),
                    )
                    .toJson(),
              );
        }
      });

  Future<void> addMovieToList({
    required MovieList movieList,
    required String movieID,
  }) async =>
      _listsRef.doc(movieList.listID).update({
        'ids': FieldValue.arrayUnion([movieID])
      });

  Future<void> removeMovieFromList({
    required MovieList movieList,
    required String movieID,
  }) async =>
      _listsRef.doc(movieList.listID).update({
        'ids': FieldValue.arrayRemove([movieID])
      });
}
