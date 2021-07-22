//Comments list item
import 'package:eclipse_tz/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:eclipse_tz/resources.dart';

class ListItem extends StatelessWidget {
  final Comment _comment;

  const ListItem(this._comment);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.maxFinite,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: _CommentDescription(
                title: _comment.name ?? '',
                email: _comment.email ?? '',
                text: _comment.body ?? '',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentDescription extends StatelessWidget {
  const _CommentDescription({
    Key key,
    this.title,
    this.email,
    this.text,
  }) : super(key: key);

  final String title;
  final String email;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: AppColors.textTitle,
            ),
          ),
          const SizedBox(width: 1, height: 10),
          Text(
            email,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textTitle,
            ),
          ),
          const SizedBox(width: 1, height: 10),
          Text(
            text,
            maxLines: 5,
            softWrap: true,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSub,
            ),
          ),
          Divider(height: 10.0, color: AppColors.divider),
        ],
      ),
    );
  }
}
