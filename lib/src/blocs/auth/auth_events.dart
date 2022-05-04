part of 'auth_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationInit extends AuthenticationEvent {
  final BuildContext context;
  const AuthenticationInit(this.context);
}

class LoginRequestedEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final BuildContext context;

  const LoginRequestedEvent(
      {required this.email, required this.password, required this.context});
}

class LogoutRequestedEvent extends AuthenticationEvent {
  final BuildContext context;
  const LogoutRequestedEvent(this.context);
}
