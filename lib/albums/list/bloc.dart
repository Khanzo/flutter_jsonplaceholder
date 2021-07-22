//Albums bloc
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eclipse_tz/api/api.dart' as api;

abstract class AlbumsEvent {
  Stream<AlbumsState> _mapToState(
    AlbumsState state,
    AlbumsBloc bloc,
  );
}

class LoadAlbums extends AlbumsEvent {
  int _userId;

  LoadAlbums(userId) {
    _userId = userId;
  }

  @override
  Stream<AlbumsState> _mapToState(
    AlbumsState state,
    AlbumsBloc bloc,
  ) async* {
    yield LoadingAlbums();

    try {
      List<api.Album> dataAlbums = new List.empty();
      final json =
          await api.defaultApiClient.getPrefJson("albums?userId=${_userId}");
      if (json == null) {
        final _jsonValue = await api.defaultApiClient
            .getJsonDataList("albums?userId=${_userId}");
        dataAlbums =
            _jsonValue.map((userMap) => api.Album.fromMap(userMap)).toList();
      } else {
        final _jsonValue = api.defaultApiClient.getJsonToList(json);
        dataAlbums =
            _jsonValue.map((userMap) => api.Album.fromMap(userMap)).toList();
      }
      yield LoadedAlbums(dataAlbums, albums: dataAlbums);
    } on Exception catch (e) {
      yield AlbumsLoadingError('$e');
    }
  }
}

abstract class AlbumsState {}

class LoadingAlbums extends AlbumsState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class AlbumsLoadingError extends AlbumsState {
  final String message;

  AlbumsLoadingError(this.message);
}

class LoadedAlbums extends AlbumsState {
  final List<api.Album> _albums;
  final List<api.Album> _cachedAlbumsList;

  LoadedAlbums(this._cachedAlbumsList, {List<api.Album> albums})
      : _albums = albums;

  List<api.Album> get albums {
    return _albums.toList(growable: false);
  }

  LoadedAlbums copyWith(
      {final List<api.Album> albums, final List<api.Album> cachedAlbumsList}) {
    return LoadedAlbums(cachedAlbumsList ?? _cachedAlbumsList,
        albums: albums ?? _albums);
  }
}

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  @override
  AlbumsState get initialState => LoadingAlbums();

  @override
  Stream<AlbumsState> mapEventToState(AlbumsEvent event) async* {
    yield* event._mapToState(state, this);
  }

  AlbumsBloc();
}
