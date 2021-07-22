//Comments bloc
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eclipse_tz/api/api.dart' as api;

abstract class CommentsEvent {
  Stream<CommentsState> _mapToState(
    CommentsState state,
    CommentsBloc bloc,
  );
}

class LoadComments extends CommentsEvent {
  int _postId;

  LoadComments(postId) {
    _postId = postId;
  }

  @override
  Stream<CommentsState> _mapToState(
    CommentsState state,
    CommentsBloc bloc,
  ) async* {
    yield LoadingComments();

    try {
      List<api.Comment> dataComments = new List.empty();
      final json =
          await api.defaultApiClient.getPrefJson("comments?postId=${_postId}");
      if (json == null) {
        final _jsonValue = await api.defaultApiClient
            .getJsonDataList("comments?postId=${_postId}");
        dataComments =
            _jsonValue.map((userMap) => api.Comment.fromMap(userMap)).toList();
      } else {
        final _jsonValue = api.defaultApiClient.getJsonToList(json);
        dataComments =
            _jsonValue.map((userMap) => api.Comment.fromMap(userMap)).toList();
      }
      yield LoadedComments(dataComments, comments: dataComments);
    } on Exception catch (e) {
      yield CommentsLoadingError('$e');
    }
  }
}

abstract class CommentsState {}

class LoadingComments extends CommentsState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class CommentsLoadingError extends CommentsState {
  final String message;

  CommentsLoadingError(this.message);
}

class LoadedComments extends CommentsState {
  final List<api.Comment> _comments;
  final List<api.Comment> _cachedCommentsList;

  LoadedComments(this._cachedCommentsList, {List<api.Comment> comments})
      : _comments = comments;

  List<api.Comment> get comments {
    return _comments.toList(growable: false);
  }

  LoadedComments copyWith(
      {final List<api.Comment> comments,
      final List<api.Comment> cachedCommentsList}) {
    return LoadedComments(cachedCommentsList ?? _cachedCommentsList,
        comments: comments ?? _comments);
  }
}

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  @override
  CommentsState get initialState => LoadingComments();

  @override
  Stream<CommentsState> mapEventToState(CommentsEvent event) async* {
    yield* event._mapToState(state, this);
  }

  CommentsBloc();
}
