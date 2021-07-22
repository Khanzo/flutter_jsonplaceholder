//Posts bloc
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eclipse_tz/api/api.dart' as api;

abstract class PostsEvent {
  Stream<PostsState> _mapToState(
    PostsState state,
    PostsBloc bloc,
  );
}

class LoadPosts extends PostsEvent {
  int _userId;

  LoadPosts(userId) {
    _userId = userId;
  }

  @override
  Stream<PostsState> _mapToState(
    PostsState state,
    PostsBloc bloc,
  ) async* {
    yield LoadingPosts();

    try {
      List<api.Post> dataPosts = new List.empty();
      final json =
          await api.defaultApiClient.getPrefJson("posts?userId=${_userId}");
      if (json == null) {
        final _jsonValue = await api.defaultApiClient
            .getJsonDataList("posts?userId=${_userId}");
        dataPosts =
            _jsonValue.map((userMap) => api.Post.fromMap(userMap)).toList();
      } else {
        final _jsonValue = api.defaultApiClient.getJsonToList(json);
        dataPosts =
            _jsonValue.map((userMap) => api.Post.fromMap(userMap)).toList();
      }
      yield LoadedPosts(dataPosts, posts: dataPosts);
    } on Exception catch (e) {
      yield PostsLoadingError('$e');
    }
  }
}

abstract class PostsState {}

class LoadingPosts extends PostsState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class PostsLoadingError extends PostsState {
  final String message;

  PostsLoadingError(this.message);
}

class LoadedPosts extends PostsState {
  final List<api.Post> _posts;
  final List<api.Post> _cachedPostsList;

  LoadedPosts(this._cachedPostsList, {List<api.Post> posts}) : _posts = posts;

  List<api.Post> get posts {
    return _posts.toList(growable: false);
  }

  LoadedPosts copyWith(
      {final List<api.Post> posts, final List<api.Post> cachedPostsList}) {
    return LoadedPosts(cachedPostsList ?? _cachedPostsList,
        posts: posts ?? _posts);
  }
}

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  @override
  PostsState get initialState => LoadingPosts();

  @override
  Stream<PostsState> mapEventToState(PostsEvent event) async* {
    yield* event._mapToState(state, this);
  }

  PostsBloc();
}
