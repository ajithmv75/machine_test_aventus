import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings/app_strings.dart';

class ProfileWidget{
  PreferredSizeWidget buildProfileAppbar(BuildContext context) {
    return AppBar(
      title: Text(AppStrings().profile,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}