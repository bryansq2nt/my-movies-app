import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movies_app/src/blocs/auth/auth_bloc.dart';

class BlocProviders {
  static final List<BlocProvider> providers = [
    BlocProvider<AuthenticationBloc>(create: (_) => AuthenticationBloc()),
  ];
}
