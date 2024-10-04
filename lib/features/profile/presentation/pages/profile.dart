import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/profile_bloc.dart';
import '../bloc/profile_state.dart';
import '../widgets/profile_widget.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileWidget().buildProfileAppbar(context),
      body: Center(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileInitial) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (state is Authenticated) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text(state.user.displayName ?? "Value not found")),
                  Center(child: Text(state.user.email ?? "Value not found")),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
