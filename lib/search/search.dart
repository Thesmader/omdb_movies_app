import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omdb_movies_app/create_list/create_list.dart';
import 'package:omdb_movies_app/providers/providers.dart';

class MovieSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final searchResults = ref.watch(searchResultsProvider(query));
        return Padding(
          padding: const EdgeInsets.all(16),
          child: searchResults.when(
            data: (movies) {
              return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: movie.poster,
                        width: 80,
                      ),
                      title: Text(movie.title),
                      trailing: IconButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (context) => MovieListBottomSheet(
                              movieID: movie.imdbID!,
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.add_rounded,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    );
                  });
            },
            error: (_, __) => Text(_.toString()),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class MovieListBottomSheet extends ConsumerWidget {
  const MovieListBottomSheet({super.key, required this.movieID});

  final String movieID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userLists = ref.watch(userListsProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const CreateListDialog(),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
            ),
            child: const Text('New Playlist'),
          ),
          userLists.when(
            data: (lists) {
              return Expanded(
                child: ListView.builder(
                  itemCount: lists.docs.length,
                  itemBuilder: (context, index) {
                    final list = lists.docs[index].data();
                    return ListTile(
                      onTap: () {
                        ref
                            .read(firestoreRepositoryProvider)
                            .addMovieToList(
                              movieList:
                                  list.copyWith(ids: [...list.ids, movieID]),
                              movieID: movieID,
                            )
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Movie was added to list: ${list.name}',
                              ),
                            ),
                          );
                          Navigator.of(context).pop();
                        });
                      },
                      title: Text(
                        lists.docs[index].data().name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  },
                ),
              );
            },
            error: (_, __) => const SizedBox(),
            loading: () => const SizedBox(),
          ),
        ],
      ),
    );
  }
}
