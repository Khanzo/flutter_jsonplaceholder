//Albums list
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';
import 'list_item.dart';
import 'package:eclipse_tz/resources.dart';
import 'package:eclipse_tz/common/loading_indicator.dart';

class AlbumsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int userId = ModalRoute.of(context).settings.arguments ?? 1;

    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.albumsList),
        ),
        body: BlocProvider<AlbumsBloc>(
          lazy: false,
          create: (context) => AlbumsBloc()
            ..add(
              LoadAlbums(userId),
            ),
          child: loadAlbums(context),
        ));
  }

  Widget loadAlbums(BuildContext context) {
    return BlocBuilder<AlbumsBloc, AlbumsState>(
      builder: (context, state) {
        if (state is LoadedAlbums) {
          if (state.albums.length > 0) {
            return ListView.builder(
              itemCount: state.albums.length,
              itemBuilder: (context, index) {
                return ListItem(state.albums[index]);
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
