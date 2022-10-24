import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omdb_movies_app/firebase_options.dart';
import 'package:omdb_movies_app/home/home.dart';
import 'package:omdb_movies_app/movie_list_ui/view/movie_list_view.dart';
import 'package:omdb_movies_app/splash/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (context) => const SplashView(),
          '/sign-in': (context) => const SignInView(),
          '/sign-up': (context) => const SignUpView(),
          '/home': (context) => const Homeview(),
          '/list': (context) => const MovieListView(),
        },
        initialRoute: '/',
      ),
    );
  }
}
