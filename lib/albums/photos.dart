//Photos slider
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eclipse_tz/resources.dart';
import 'package:eclipse_tz/common/loading_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'bloc.dart';
import 'list_item.dart';

class PhotoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int albumId = ModalRoute.of(context).settings.arguments ?? 1;

    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.photosList),
        ),
        body: BlocProvider<PhotosBloc>(
          lazy: false,
          create: (context) => PhotosBloc()
            ..add(
              LoadPhotos(albumId),
            ),
          child: loadPhotos(context),
        ));
  }

  Widget loadPhotos(BuildContext context) {
    return BlocBuilder<PhotosBloc, PhotosState>(
      builder: (context, state) {
        if (state is LoadedPhotos) {
          if (state.photos.length > 0) {
            return CarouselSlider.builder(
                itemCount: state.photos.length,
                itemBuilder: (context, index) {
                  return ListItem(state.photos[index]);
                });
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
