import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/features/profile/presentation/bloc/profile_event.dart';
import 'package:machine_test/features/profile/presentation/bloc/profile_state.dart';

import '../../domain/use_cases/profile_usecase.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUseCase _profileUseCase;
  ProfileBloc(this._profileUseCase)
      : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      final user = _profileUseCase();
      print("asasasa: $user");
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    });
  }
}
