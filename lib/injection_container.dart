import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'features/app/splash/bloc/splash_screen_bloc.dart';
import 'features/auth/data/repositories_impl/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/use_cases/auth_check_usecase.dart';
import 'features/auth/domain/use_cases/signout_usecase.dart';
import 'features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'features/profile/domain/use_cases/profile_usecase.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/signin/data/repository_impl/signin_repository_impl.dart';
import 'features/signin/domain/repositories/signin_repository.dart';
import 'features/signin/domain/use_cases/google_signin_usecase.dart';
import 'features/signin/domain/use_cases/signin_usecase.dart';
import 'features/signin/presentation/bloc/signin_bloc.dart';
import 'features/signup/data/repositories_impl/signup_repository_impl.dart';
import 'features/signup/domain/repositories/signup_repository.dart';
import 'features/signup/domain/use_cases/signup_usecase.dart';
import 'features/signup/presentation/bloc/google_signin/presentation/google_signin_bloc/google_signin_bloc.dart';
import 'features/signup/presentation/bloc/signup_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  ///     Common      ///
  sl.registerLazySingleton(() => http.Client());
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerSingleton<GoogleSignIn>(GoogleSignIn());

  ///  repository ///
  sl.registerSingleton<SignupRepository>(SignupRepositoryImpl(sl<FirebaseAuth>(),));
  sl.registerSingleton<SigninRepository>(SigninRepositoryImpl(sl<FirebaseAuth>(), sl<GoogleSignIn>()));
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl<FirebaseAuth>(), sl<GoogleSignIn>()));

  /// usecases ///
  sl.registerSingleton<SignupUseCase>(SignupUseCase(sl()));
  sl.registerSingleton<SigninUseCase>(SigninUseCase(sl<SigninRepository>()));
  sl.registerSingleton<GoogleSignInUseCase>(GoogleSignInUseCase(sl<SigninRepository>()));
  sl.registerSingleton<SignOutUseCase>(SignOutUseCase(sl<AuthRepository>()));
  sl.registerSingleton<AuthCheckUseCase>(AuthCheckUseCase(sl<AuthRepository>()));

  ///  bloc ///
  sl.registerFactory(() => SplashScreenBloc());
  sl.registerFactory(() => SigninBloc(sl<SigninUseCase>()));
  sl.registerFactory(() => SignupBloc(sl()));
  sl.registerFactory<GoogleSigninBloc>(() => GoogleSigninBloc(sl<GoogleSignInUseCase>()));
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl<SignOutUseCase>(), sl<AuthCheckUseCase>()));


  ///     Profile      ///
  sl.registerSingleton<ProfileUseCase>(ProfileUseCase(sl<AuthRepository>()));
  sl.registerFactory(() => ProfileBloc(sl<ProfileUseCase>()));

}
