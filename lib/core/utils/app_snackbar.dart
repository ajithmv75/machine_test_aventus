import 'package:flutter/material.dart';

void appSncakBar({required BuildContext context, String message = ""}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
