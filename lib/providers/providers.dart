import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omdb_movies_app/home/home.dart';
import 'package:omdb_movies_app/repositories/repositories.dart';

final firebaseAuthRepositoryProvider = Provider(
  (ref) => FirebaseAuthRepository(),
);

final httpRepositoryProvider = Provider((ref) => HttpRepository());

final authStateProvider = StreamProvider(
  (ref) => ref.read(firebaseAuthRepositoryProvider).authStateChanges,
);

final firestoreRepositoryProvider = Provider(
  (ref) => FirestoreRepository(),
);

final appUserProvider = FutureProvider((ref) async {
  final user = ref.read(authStateProvider);

  if (user.asData?.value != null) {
    return ref
        .read(firestoreRepositoryProvider)
        .getAppUser(user.asData!.value!.uid);
  }
});

final publicListsProvider = StreamProvider((ref) {
  return ref.read(firestoreRepositoryProvider).publicLists;
});

final userListsProvider = StreamProvider<QuerySnapshot<MovieList>>((ref) {
  final appUser = ref.watch(appUserProvider);
  return appUser.when(
    data: (value) {
      if (value != null) {
        return ref.read(firestoreRepositoryProvider).userLists(value);
      }
      return Stream.fromIterable([]);
    },
    error: (_, __) {
      return Stream.fromIterable([]);
    },
    loading: () {
      return Stream.fromIterable([]);
    },
  );
});

final listProvider =
    FutureProvider.autoDispose.family<MovieList?, String>((ref, listID) {
  return ref.read(firestoreRepositoryProvider).getList(listID);
});

final searchResultsProvider =
    FutureProvider.family<List<Movie>, String>((ref, query) {
  return ref.read(httpRepositoryProvider).searchMovies(query);
});

final movieProvider = FutureProvider.family<Movie, String>(
  (ref, movieID) => ref.read(httpRepositoryProvider).getMovie(movieID),
);
