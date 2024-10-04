import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/app_loading_widget.dart';
import '../../../../core/widgets/button_widget.dart';
import '../../../signup/presentation/bloc/google_signin/presentation/google_signin_bloc/google_signin_bloc.dart';
import '../bloc/signin_bloc.dart';
import '../bloc/signin_event.dart';
import '../bloc/signin_state.dart';

class GoogleSignInButtonWidget extends StatelessWidget {
  const GoogleSignInButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleSigninBloc, GoogleSigninState>(
        builder: (context, state) {
      if (state is GoogleSigninLoading) {
        return const AppLoadingWidget();
      }
      return ButtonWidget(
        onPressed: () {
          context
              .read<GoogleSigninBloc>()
              .add(GoogleSignInButtonClickedEvent());
        },
        buttonText: "google",
      );
    });
  }
}

class SignInButtonWidget extends StatelessWidget {
  const SignInButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninBloc, SigninState>(builder: (context, state) {
      return state.isLoading
          ? const AppLoadingWidget()
          : ButtonWidget(
              onPressed: () {
                context.read<SigninBloc>().add(SigninFormSubmittedSignin());
              },
              buttonText: "signin",
            );
    });
  }
}


class SignInPhoneWidget extends StatelessWidget {
  const SignInPhoneWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninBloc, SigninState>(builder: (context, state) {
      return state.isLoading
          ? const AppLoadingWidget()
          : ButtonWidget(
        onPressed: () {
          // context.read<SigninBloc>().add(SigninFormSubmittedSignin());
          Navigator.pushNamed(context, '/PhoneSignin');
        },
        buttonText: "phone",
      );
    });
  }
}