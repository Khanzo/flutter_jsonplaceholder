//Users list item
import 'package:eclipse_tz/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:eclipse_tz/resources.dart';
import 'package:eclipse_tz/common/icons_m_size.dart';

class ListItem extends StatelessWidget {
  final User _user;

  const ListItem(this._user);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/user', arguments: _user),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.maxFinite,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: _UserDescription(
                username: _user.username ?? '',
                name: _user.name ?? '',
              ),
            ),
            const Icon(MSizeIcons.chevron_right1)
          ],
        ),
      ),
    );
  }
}

class _UserDescription extends StatelessWidget {
  const _UserDescription({
    Key key,
    this.username,
    this.name,
  }) : super(key: key);

  final String username;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            username,
            style: const TextStyle(
              fontSize: 20,
              color: AppColors.textTitle,
            ),
          ),
          const SizedBox(width: 1, height: 10),
          Text(
            name,
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
