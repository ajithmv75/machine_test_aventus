import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/auth_bloc/auth_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              Timer(const Duration(seconds: 3), () {
                Navigator.pushReplacementNamed(context, '/Home');
              });
            } else {
              Timer(const Duration(seconds: 3), () {
                Navigator.pushReplacementNamed(context, '/Signin');
              });
            }
          },
        )
      ],
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                width: 70,
                height: 70,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text("Machine test")
            ],
          ),
        ),
      ),
    );
  }
}
