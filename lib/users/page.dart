//User detail info
import 'package:eclipse_tz/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:eclipse_tz/resources.dart';
import 'package:eclipse_tz/common/icons_m_size.dart';
import 'package:auto_size_text/auto_size_text.dart';

class UserPage extends StatefulWidget {
  const UserPage();

  @override
  State<StatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  static const _kHeight = 400.0;
  User _user;

  @override
  Widget build(BuildContext context) {
    _user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text(_user.username),
        ),
        body: loadUser(context));
  }

  Widget loadUser(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tagBlue,
      body: Stack(
        children: <Widget>[
          _GradientBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                child: Material(
                    color: Colors.transparent,
                    child: Column(children: <Widget>[
                      Container(
                          height: _kHeight,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                _InfoData(
                                  title: Strings.userName,
                                  text: _user.name ?? "",
                                ),
                                const SizedBox(height: 6),
                                _InfoData(
                                  title: Strings.userEmail,
                                  text: _user.email ?? "",
                                ),
                                const SizedBox(height: 6),
                                _InfoData(
                                  title: Strings.userPhone,
                                  text: _user.phone ?? "",
                                ),
                                const SizedBox(height: 6),
                                _InfoData(
                                  title: Strings.userSite,
                                  text: _user.website ?? "",
                                ),
                                const SizedBox(height: 6),
                                _InfoData(
                                  title: Strings.userWork,
                                  text: "${_user.companyName}\n"
                                          "${_user.companyCatchPhrase}\n"
                                          "${_user.companyBs}" ??
                                      "",
                                ),
                                const SizedBox(height: 6),
                                _InfoData(
                                  title: Strings.userAdress,
                                  text:
                                      "${_user.addressZipcode} ${_user.addressCity}\n"
                                              "${_user.addressStreet}\n"
                                              "${_user.addressSuite}" ??
                                          "",
                                ),
                                const SizedBox(height: 10),
                              ])),
                      const SizedBox(height: 8),
                      _Service.posts(_user.id),
                      const SizedBox(height: 8),
                      _Service.albums(_user.id),
                      const SizedBox(height: 10),
                    ])),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoData extends StatelessWidget {
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.darkGradient1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          text ?? "",
          maxLines: 5,
          softWrap: true,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.colorWhite,
          ),
        ),
      ],
    );
  }

  const _InfoData({
    @required this.title,
    @required this.text,
  });
}

class _Service extends StatelessWidget {
  final Icon _icon;
  final String _text;
  final String _routeNavigator;
  final int userId;

  _Service.posts(int id)
      : this._icon = Icon(MSizeIcons.personal_card),
        this._text = Strings.postsList,
        this.userId = id,
        this._routeNavigator = '/posts';

  _Service.albums(int id)
      : this._icon = Icon(MSizeIcons.picture),
        this._text = Strings.albumsList,
        this.userId = id,
        this._routeNavigator = '/albums';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 8).copyWith(
        left: 16,
        right: 16,
      ),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 20),
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, _routeNavigator, arguments: userId);
        },
        child: Row(
          children: <Widget>[
            _icon,
            const SizedBox(width: 24),
            Expanded(
              child: AutoSizeText(
                _text,
                maxFontSize: 16,
                softWrap: true,
                style: const TextStyle(
                  color: AppColors.textTitle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GradientBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: const BoxDecoration(
        color: AppColors.gradientMain1,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(32)),
        gradient: LinearGradient(
          colors: [
            AppColors.gradientMain1,
            AppColors.gradientMain3,
          ],
          begin: Alignment(-1.0, 1.0),
          end: Alignment(1.0, -1.0),
        ),
      ),
    );
  }
}
