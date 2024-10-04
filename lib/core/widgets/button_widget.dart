import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;

  const ButtonWidget({
    Key? key,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(
              vertical: 12),
        ),
        onPressed: onPressed,
        child: Text(buttonText),
      ),
    );
  }
}
