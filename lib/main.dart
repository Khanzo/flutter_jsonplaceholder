import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'users/list/page.dart';
import 'users/page.dart';
import 'posts/list/page.dart';
import 'posts/page.dart';
import 'comments/page.dart';
import 'albums/list/page.dart';
import 'albums/photos.dart';
import 'package:eclipse_tz/resources.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: Strings.title,
      home: UsersPage(),
      routes: {
        '/users': (context) => UsersPage(),
        '/user': (context) => UserPage(),
        '/posts': (context) => PostsPage(),
        '/post': (context) => PostPage(),
        '/comment': (context) => AddCommentPage(),
        '/albums': (context) => AlbumsPage(),
        '/photos': (context) => PhotoPage(),
      },
    );
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}
