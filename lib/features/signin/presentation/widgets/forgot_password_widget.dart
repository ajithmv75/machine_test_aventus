import 'package:flutter/material.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/ForgotPassword');
        },
        child: const Center(
          child: Text('Forgot password?',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
