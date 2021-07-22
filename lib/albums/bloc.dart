//Photo bloc
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eclipse_tz/api/api.dart' as api;

abstract class PhotosEvent {
  Stream<PhotosState> _mapToState(
    PhotosState state,
    PhotosBloc bloc,
  );
}

class LoadPhotos extends PhotosEvent {
  int _albumId;

  LoadPhotos(albumId) {
    _albumId = albumId;
  }

  @override
  Stream<PhotosState> _mapToState(
    PhotosState state,
    PhotosBloc bloc,
  ) async* {
    yield LoadingPhotos();

    try {
      List<api.Photo> dataPhotos = new List.empty();
      final json =
          await api.defaultApiClient.getPrefJson("photos?albumId=${_albumId}");
      if (json == null) {
        final _jsonValue = await api.defaultApiClient
            .getJsonDataList("photos?albumId=${_albumId}");
        dataPhotos =
            _jsonValue.map((userMap) => api.Photo.fromMap(userMap)).toList();
      } else {
        final _jsonValue = api.defaultApiClient.getJsonToList(json);
        dataPhotos =
            _jsonValue.map((userMap) => api.Photo.fromMap(userMap)).toList();
      }
      yield LoadedPhotos(dataPhotos, photos: dataPhotos);
    } on Exception catch (e) {
      yield PhotosLoadingError('$e');
    }
  }
}

abstract class PhotosState {}

class LoadingPhotos extends PhotosState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class PhotosLoadingError extends PhotosState {
  final String message;

  PhotosLoadingError(this.message);
}

class LoadedPhotos extends PhotosState {
  final List<api.Photo> _photos;
  final List<api.Photo> _cachedPhotosList;

  LoadedPhotos(this._cachedPhotosList, {List<api.Photo> photos})
      : _photos = photos;

  List<api.Photo> get photos {
    return _photos.toList(growable: false);
  }

  LoadedPhotos copyWith(
      {final List<api.Photo> photos, final List<api.Photo> cachedPhotosList}) {
    return LoadedPhotos(cachedPhotosList ?? _cachedPhotosList,
        photos: photos ?? _photos);
  }
}

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  @override
  PhotosState get initialState => LoadingPhotos();

  @override
  Stream<PhotosState> mapEventToState(PhotosEvent event) async* {
    yield* event._mapToState(state, this);
  }

  PhotosBloc();
}
