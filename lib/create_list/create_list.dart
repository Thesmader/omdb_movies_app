import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omdb_movies_app/home/home.dart';
import 'package:omdb_movies_app/providers/providers.dart';

class CreateListDialog extends ConsumerStatefulWidget {
  const CreateListDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateListDialogState();
}

class _CreateListDialogState extends ConsumerState<CreateListDialog> {
  final nameController = TextEditingController();
  String type = 'private';

  @override
  Widget build(BuildContext context) {
    final user = ref.read(authStateProvider).asData!.value;
    final appUser = ref.read(appUserProvider).asData!.value;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: Builder(builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Create New List'),
                const SizedBox(height: 10),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value != null) {
                      if (value.length < 3) {
                        return 'Plase enter atleast 3 characters';
                      }
                      return null;
                    } else {
                      return 'Please enter atleast 3 characters';
                    }
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Radio(
                      value: 'private',
                      groupValue: type,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            type = val;
                          });
                        }
                      },
                    ),
                    const Text('Private'),
                    Radio(
                      value: 'public',
                      groupValue: type,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            type = val;
                          });
                        }
                      },
                    ),
                    const Text('Public')
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (Form.of(context)!.validate()) {
                      ref
                          .read(firestoreRepositoryProvider)
                          .createList(
                            movieList: MovieList(
                              private: type == 'private',
                              name: nameController.text.trim(),
                              ids: [],
                              by: user!.displayName ?? user.uid,
                            ),
                            userId: user.uid,
                            user: appUser!,
                          )
                          .then(
                        (value) {
                          ref.refresh(appUserProvider);
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  },
                  child: const Text('Create'),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
