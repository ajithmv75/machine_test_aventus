import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_snackbar.dart';
import '../../../signup/presentation/bloc/google_signin/presentation/google_signin_bloc/google_signin_bloc.dart';
import '../bloc/signin_bloc.dart';
import '../bloc/signin_state.dart';
import '../widgets/signin_button_widget.dart';
import '../widgets/signin_logo_widget.dart';

class Signin extends StatelessWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SigninBloc, SigninState>(
          listener: (context, state) {
            if (state.formSubmittedSuccessfully) {
              Navigator.pushNamed(context, '/Api');
              return;
            }

            state.failure.fold(() {}, (failure) {
              appSncakBar(context: context, message: failure.message);
            });
          },
        ),
        BlocListener<GoogleSigninBloc, GoogleSigninState>(
          listener: (context, state) {
            if (state is GoogleSigninSuccess) {
              Navigator.pushNamed(context, '/Home');
            }
            if (state is GoogleSignFailure) {
              appSncakBar(
                context: context,
                message: state.authFailures.message,
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "signin",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      bottom: 20.0,
                    ),
                    child: BlocBuilder<SigninBloc, SigninState>(
                      buildWhen: (p, c) => p.isLoading != c.isLoading,
                      builder: (context, signinstate) {
                        return BlocBuilder<GoogleSigninBloc, GoogleSigninState>(
                          builder: (context, state) {
                            return AbsorbPointer(
                              absorbing: signinstate.isLoading ||
                                  state is GoogleSigninLoading,
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  SignInLogoWidget(),
                                  GoogleSignInButtonWidget(),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
