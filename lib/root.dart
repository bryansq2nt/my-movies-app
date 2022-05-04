import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/src/ui/home/home_screen.dart';
import 'package:my_movies_app/src/ui/login/login_screen.dart';

import 'src/blocs/auth/auth_bloc.dart';

class RootCheckSession extends StatelessWidget {
  const RootCheckSession({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    authBloc.add(AuthenticationInit(context));
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previousState, currentState) => previousState != currentState,
      bloc: authBloc,
      builder: (context, state) {
        if (state is LoggedInState) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
