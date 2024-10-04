part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}


class AuthSignoutButtonClicked extends AuthEvent{}
class AuthCheckEvent extends AuthEvent{}