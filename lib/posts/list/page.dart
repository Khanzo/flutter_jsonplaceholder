//Posts list
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';
import 'list_item.dart';
import 'package:eclipse_tz/resources.dart';
import 'package:eclipse_tz/common/loading_indicator.dart';

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int userId = ModalRoute.of(context).settings.arguments ?? 1;

    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.postsList),
        ),
        body: BlocProvider<PostsBloc>(
          lazy: false,
          create: (context) => PostsBloc()
            ..add(
              LoadPosts(userId),
            ),
          child: loadPosts(context),
        ));
  }

  Widget loadPosts(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is LoadedPosts) {
          if (state.posts.length > 0) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                return ListItem(state.posts[index]);
              },
            );
          } else {
            return const Center(
              child: Text(
                Strings.emptyData,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textSub,
                ),
              ),
            );
          }
        }
        return const Center(
          child: LoadingIndicator(),
        );
      },
    );
  }
}
