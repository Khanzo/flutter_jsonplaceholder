//Post detail info
import 'package:eclipse_tz/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:eclipse_tz/resources.dart';
import 'package:eclipse_tz/common/icons_m_size.dart';
import 'package:eclipse_tz/common/loading_indicator.dart';

import 'package:eclipse_tz/comments/bloc.dart';
import 'package:eclipse_tz/comments/list_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage();

  @override
  State<StatefulWidget> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  Post _post;

  @override
  Widget build(BuildContext context) {
    _post = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(_post.title),
      ),
      body: Column(children: <Widget>[
        loadPost(context),
        Expanded(
            child: BlocProvider<CommentsBloc>(
          lazy: false,
          create: (context) => CommentsBloc()
            ..add(
              LoadComments(_post.id),
            ),
          child: loadComments(context),
        )),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, '/comment', arguments: _post),
        child: Icon(MSizeIcons.pen_small),
      ),
    );
  }

  Widget loadPost(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _post.body,
                softWrap: true,
                style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.textTitle,
                ),
              ),
              const SizedBox(width: 1, height: 10),
              Text(
                Strings.commentsList,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.colorBar,
                ),
              ),
              Divider(height: 10.0, color: AppColors.divider),
            ]));
  }

  Widget loadComments(BuildContext context) {
    return BlocBuilder<CommentsBloc, CommentsState>(
      builder: (context, state) {
        if (state is LoadedComments) {
          if (state.comments.length > 0) {
            return ListView.builder(
              itemCount: state.comments.length,
              itemBuilder: (context, index) {
                return ListItem(state.comments[index]);
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
