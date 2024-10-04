part of 'google_signin_bloc.dart';

sealed class GoogleSigninState extends Equatable {
  const GoogleSigninState();

  @override
  List<Object> get props => [];
}

final class GoogleSigninInitial extends GoogleSigninState {}

final class GoogleSigninLoading extends GoogleSigninState {}

final class GoogleSigninSuccess extends GoogleSigninState {}

final class GoogleSignFailure extends GoogleSigninState {
  final AuthFailures authFailures;

  const GoogleSignFailure(this.authFailures);
}
