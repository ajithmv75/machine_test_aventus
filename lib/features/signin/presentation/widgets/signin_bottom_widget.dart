import 'package:flutter/material.dart';

class SignInBottomWidget extends StatelessWidget {
  const SignInBottomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("AppLocalizations.of(context)!.donthaveanaccount"),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/Signup');
            },
            child: Text(
              "AppLocalizations.of(context)!.signup",
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
