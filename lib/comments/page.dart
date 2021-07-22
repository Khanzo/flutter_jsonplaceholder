//Add comment
import 'package:eclipse_tz/api/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:eclipse_tz/resources.dart';
import 'package:eclipse_tz/api/api.dart' as api;

class AddCommentPage extends StatefulWidget {
  const AddCommentPage();

  @override
  State<StatefulWidget> createState() => _AddCommentPageState();
}

class _AddCommentPageState extends State<AddCommentPage> {
  Post _post;

  @override
  Widget build(BuildContext context) {
    _post = ModalRoute.of(context).settings.arguments;
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _commController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.addComment),
        ),
        body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: Strings.userName),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: Strings.userEmail),
                ),
                TextField(
                  controller: _commController,
                  decoration: InputDecoration(hintText: Strings.commentBody),
                ),
                ElevatedButton(
                  onPressed: () {
                    api.defaultApiClient
                        .updateComments(
                            _nameController.text,
                            _emailController.text,
                            _commController.text,
                            _post.id)
                        .then((comment) =>
                            api.defaultApiClient.sendCommentData(comment))
                        .then((value) => Navigator.popAndPushNamed(
                            context, '/post',
                            arguments: _post));
                  },
                  child: Text('Отправить'),
                ),
              ],
            )));
  }
}
