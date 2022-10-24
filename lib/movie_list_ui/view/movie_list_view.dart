import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omdb_movies_app/providers/providers.dart';

class MovieListView extends ConsumerWidget {
  const MovieListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieListID = ModalRoute.of(context)!.settings.arguments as String;
    final movieList = ref.watch(listProvider(movieListID));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: movieList.maybeMap(
            orElse: () => const Text(''),
            data: (list) => Text(list.value?.name ?? ''),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: movieList.when(
            data: (list) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movieData = ref.watch(movieProvider(list!.ids[index]));
                  return movieData.when(
                    data: (movie) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: movie.poster,
                                fit: BoxFit.cover,
                                width: 100,
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.title,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      movie.year,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    error: (_, __) => const Center(child: Icon(Icons.error)),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                itemCount: list?.ids.length ?? 0,
              );
            },
            error: (_, __) => Text(_.toString()),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
