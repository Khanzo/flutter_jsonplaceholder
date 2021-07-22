//Albums list item
import 'package:eclipse_tz/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:eclipse_tz/resources.dart';
import 'package:eclipse_tz/common/icons_m_size.dart';

class ListItem extends StatelessWidget {
  final Album _album;

  const ListItem(this._album);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, '/photos', arguments: _album.id),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.maxFinite,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Text(
                _album.title,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.textTitle,
                ),
              ),
            ),
            const Icon(MSizeIcons.chevron_right1)
          ],
        ),
      ),
    );
  }
}
