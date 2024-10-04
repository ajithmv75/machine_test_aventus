import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/features/home/presentation/bloc/home/home_bloc.dart';
import 'package:machine_test/features/home/presentation/bloc/home/home_event.dart';

import '../../features/app/splash/bloc/splash_screen_bloc.dart';
import '../../features/auth/presentation/auth_bloc/auth_bloc.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import '../../features/signin/presentation/bloc/signin_bloc.dart';
import '../../features/signup/presentation/bloc/google_signin/presentation/google_signin_bloc/google_signin_bloc.dart';
import '../../features/signup/presentation/bloc/signup_bloc.dart';
import '../../injection_container.dart';

List<BlocProvider> providers = [
  BlocProvider<SplashScreenBloc>(
    create: (context) => sl<SplashScreenBloc>()..add(getUID()),
  ),
  BlocProvider<SignupBloc>(
    create: (context) => sl<SignupBloc>(),
  ),
  BlocProvider<SigninBloc>(
    create: (context) => sl<SigninBloc>(),
  ),
  BlocProvider<GoogleSigninBloc>(
    create: (context) => sl<GoogleSigninBloc>(),
  ),
  BlocProvider<AuthBloc>(
    create: (context) => sl<AuthBloc>()..add(AuthCheckEvent()),
  ),
  BlocProvider<ProfileBloc>(
    create: (context) => sl<ProfileBloc>(),
  ),
  // BlocProvider<HomeBloc>(
  //   create: (context) => sl<HomeBloc>()..add(LoadProductsEvent()),
  // ),
];
