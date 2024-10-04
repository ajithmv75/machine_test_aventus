import 'package:flutter/cupertino.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
