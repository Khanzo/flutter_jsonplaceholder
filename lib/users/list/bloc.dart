//Users list bloc
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eclipse_tz/api/api.dart' as api;

abstract class UsersEvent {
  Stream<UsersState> _mapToState(
    UsersState state,
    UsersBloc bloc,
  );
}

class LoadUsers extends UsersEvent {
  @override
  Stream<UsersState> _mapToState(
    UsersState state,
    UsersBloc bloc,
  ) async* {
    yield LoadingUsers();

    try {
      List<api.User> dataUsers = new List.empty();
      final json = await api.defaultApiClient.getPrefJson("users");
      if (json == null) {
        final _jsonValue = await api.defaultApiClient.getJsonDataList("users");
        dataUsers =
            _jsonValue.map((userMap) => api.User.fromMap(userMap)).toList();
      } else {
        final _jsonValue = api.defaultApiClient.getJsonToList(json);
        dataUsers =
            _jsonValue.map((userMap) => api.User.fromMap(userMap)).toList();
      }
      yield LoadedUsers(dataUsers, users: dataUsers);
    } on Exception catch (e) {
      yield UsersLoadingError('$e');
    }
  }
}

abstract class UsersState {}

class LoadingUsers extends UsersState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class UsersLoadingError extends UsersState {
  final String message;

  UsersLoadingError(this.message);
}

class LoadedUsers extends UsersState {
  final List<api.User> _users;
  final List<api.User> _cachedUsersList;

  LoadedUsers(this._cachedUsersList, {List<api.User> users}) : _users = users;

  List<api.User> get users {
    return _users.toList(growable: false);
  }

  LoadedUsers copyWith(
      {final List<api.User> users, final List<api.User> cachedUsersList}) {
    return LoadedUsers(cachedUsersList ?? _cachedUsersList,
        users: users ?? _users);
  }
}

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  @override
  UsersState get initialState => LoadingUsers();

  @override
  Stream<UsersState> mapEventToState(UsersEvent event) async* {
    yield* event._mapToState(state, this);
  }

  UsersBloc();
}
