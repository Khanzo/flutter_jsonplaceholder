//Posts list item
import 'package:eclipse_tz/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:eclipse_tz/resources.dart';
import 'package:eclipse_tz/common/icons_m_size.dart';

class ListItem extends StatelessWidget {
  final Post _post;

  const ListItem(this._post);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/post', arguments: _post),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.maxFinite,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: _PostDescription(
                title: _post.title ?? '',
                text: _post.body ?? '',
              ),
            ),
            const Icon(MSizeIcons.chevron_right1)
          ],
        ),
      ),
    );
  }
}

class _PostDescription extends StatelessWidget {
  const _PostDescription({
    Key key,
    this.title,
    this.text,
  }) : super(key: key);

  final String title;
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
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.textSub,
            ),
          ),
          Divider(height: 10.0, color: AppColors.divider),
        ],
      ),
    );
  }
}
