import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omdb_movies_app/create_list/create_list.dart';
import 'package:omdb_movies_app/providers/providers.dart';
import 'package:omdb_movies_app/search/search.dart';

class Homeview extends ConsumerWidget {
  const Homeview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final publicLists = ref.watch(publicListsProvider);
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (context) => const CreateListDialog(),
              );
            },
            label: const Text('Create List'),
            icon: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: const Text('Movies'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: MovieSearch(),
                  );
                },
                icon: const Icon(Icons.search_rounded),
              ),
              IconButton(
                onPressed: () {
                  ref.read(firebaseAuthRepositoryProvider).signOut();
                },
                icon: const Icon(Icons.logout),
              )
            ],
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Public Lists'),
                Tab(text: 'Your Lists'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: publicLists.when(
                  data: (snapshot) {
                    return ListView.builder(
                        itemCount: snapshot.docs.length,
                        itemBuilder: (context, index) {
                          final list = snapshot.docs[index].data();
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  '/list',
                                  arguments: list.listID,
                                );
                              },
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    list.name,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  Text(
                                    'by ${list.by}',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  error: (_, __) => const SizedBox(),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
              ),
              const UserLists(),
            ],
          ),
        ),
      ),
    );
  }
}

class UserLists extends ConsumerWidget {
  const UserLists({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider);
    return user.when(
      data: (userData) {
        if (userData != null) {
          final userLists = ref.watch(userListsProvider);
          return userLists.when(
            data: (lists) {
              return ListView.builder(
                  itemCount: lists.docs.length,
                  itemBuilder: (context, index) {
                    final list = lists.docs[index].data();
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/list',
                            arguments: list.listID,
                          );
                        },
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${list.name}${list.private ? ' (private)' : ''}',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Text(
                              'by ${list.by}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            error: (_, __) {
              return const SizedBox();
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
          );
        }
        return const SizedBox();
      },
      error: (_, __) {
        return const SizedBox();
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
