
import 'package:flutter/material.dart';

class SignInLogoWidget extends StatelessWidget {
  const SignInLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 30.0,
        ),
        Image.asset(
          "assets/images/logo.png",
          width: 70,
          height: 70,
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Center(
          child: Text("Machine test"),
        ),
        const SizedBox(
          height: 50.0,
        ),
      ],
    );
  }
}