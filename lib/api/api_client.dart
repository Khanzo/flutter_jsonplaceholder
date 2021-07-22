// @dart=2.0
// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: lines_longer_than_80_chars

part of api;

class ApiClient {
  ApiClient({this.basePath = 'https://jsonplaceholder.typicode.com'});

  final String basePath;

  Future<List> getJsonDataList(_endpoint) async {
    try {
      String urlApi = "$basePath/$_endpoint";
      http.Response response = await http.get(urlApi);
      if (response.statusCode == 200) {
        final jsonList = jsonDecode(response.body) as List;
        if (jsonList.length > 0) {
          setPrefJson(_endpoint, response.body.toString());
        }
        return jsonList;
      }
      return List.empty();
    } on Exception catch (e) {
      return List.empty();
    }
  }

  Future<bool> sendCommentData(Comment _comment) async {
    String urlApi = "$basePath/comments";
    final response = await http.post(
      Uri.parse(urlApi),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'postId': _comment.postId.toString(),
        'name': _comment.name,
        'email': _comment.email,
        'body': _comment.body,
      }),
    );

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  /*SharedFunction*/

  Future<SharedPreferences> get _sharedPrefs async =>
      await SharedPreferences.getInstance();

  Future<bool> remove(_key) async => _sharedPrefs.then((p) => p.remove(_key));

  Future<String> getPrefJson(_key) async =>
      _sharedPrefs.then((p) => p.getString(_key));

  Future<bool> existsPrefJson(_key) async {
    final prefs = await _sharedPrefs;
    return prefs.containsKey(_key) ?? false;
  }

  Future<void> setPrefJson(_key, _value) async =>
      _sharedPrefs.then((p) => p.setString(_key, _value));

  List getJsonToList(_json) {
    return jsonDecode(_json) as List;
  }

  Future<Comment> updateComments(_name, _email, _body, _postId) async {
    List<Comment> dataComments = new List.empty();
    final key = "comments?postId=${_postId}";
    final json = await defaultApiClient.getPrefJson(key);
    final _jsonValue = defaultApiClient.getJsonToList(json);
    dataComments =
        _jsonValue.map((userMap) => Comment.fromMap(userMap)).toList();
    Comment comment = new Comment(
        id: dataComments.length + 1,
        postId: _postId,
        name: _name,
        email: _email,
        body: _body);
    dataComments.add(comment);
    String newJson = jsonEncode(dataComments)
        .replaceAll('\\', '')
        .replaceAll('["', '[')
        .replaceAll('}"', '}')
        .replaceAll('"{', '{')
        .replaceAll('"]', ']');
    setPrefJson(key, newJson);
    return comment;
  }
}
