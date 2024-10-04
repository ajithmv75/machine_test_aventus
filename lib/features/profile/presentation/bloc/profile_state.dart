import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}
final class Authenticated extends ProfileState {
  User user;
  Authenticated({required this.user});
}
final class Unauthenticated extends ProfileState {}
