//Users list
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';
import 'list_item.dart';
import 'package:eclipse_tz/resources.dart';
import 'package:eclipse_tz/common/loading_indicator.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(Strings.usersList),
        ),
        body: BlocProvider<UsersBloc>(
          lazy: false,
          create: (context) => UsersBloc()
            ..add(
              LoadUsers(),
            ),
          child: loadUsers(context),
        ));
  }

  Widget loadUsers(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        if (state is LoadedUsers) {
          if (state.users.length > 0) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return ListItem(state.users[index]);
              },
            );
          } else {
            return const Center(
              child: Text(
                Strings.emptyData,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textSub,
                ),
              ),
            );
          }
        }
        return const Center(
          child: LoadingIndicator(),
        );
      },
    );
  }
}
