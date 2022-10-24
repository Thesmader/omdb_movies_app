import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omdb_movies_app/home/home.dart';
import 'package:omdb_movies_app/providers/providers.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider);

    return Scaffold(
      body: user.when(
        data: (userData) {
          if (userData != null) {
            return const Homeview();
          } else {
            return const SignInView();
          }
        },
        error: (_, __) {
          return const SizedBox();
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          child: Builder(builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Email'),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Password'),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if ((value?.isEmpty ?? true) || (value?.length ?? 0) < 5) {
                      return 'Please enter the correct password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (Form.of(context)!.validate()) {
                      ref
                          .read(firebaseAuthRepositoryProvider)
                          .signinWithEmailPassword(
                              emailController.text, passwordController.text);
                    }
                  },
                  child: const Text('Sign In'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/sign-up');
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          child: Builder(builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Name'),
                  ),
                  validator: (value) {
                    if ((value?.isEmpty ?? true) || (value?.length ?? 0) < 5) {
                      return 'Please enter atleast 5 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Email'),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Password'),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if ((value?.isEmpty ?? true) || (value?.length ?? 0) < 5) {
                      return 'Please enter atleast 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (Form.of(context)!.validate()) {
                      ref
                          .read(firebaseAuthRepositoryProvider)
                          .signupWithEmailPassword(
                              emailController.text, passwordController.text)
                          .then((credential) async {
                        if (credential?.user != null) {
                          await credential!.user!
                              .updateDisplayName(nameController.text);
                          await ref
                              .read(firestoreRepositoryProvider)
                              .createUser(credential.user!.uid)
                              .then((value) => Navigator.of(context).pop());
                        }
                      });
                    }
                  },
                  child: const Text('Sign Up'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Sign In'),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
