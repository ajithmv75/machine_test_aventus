import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_snackbar.dart';
import '../bloc/signup_bloc.dart';
import '../bloc/signup_state.dart';

// import '../../../language/domain/entities/language_model.dart';
// import '../../../language/presentation/language_bloc/language_bloc.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state.formSubmittedSuccessfully) {
          appSncakBar(context: context, message: "Succefully signup");
          Navigator.pushNamed(context, '/Api');
        }

        state.failure.fold(() {}, (failure) {
          appSncakBar(context: context, message: failure.message);
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "AppLocalizations.of(context)!.signup",
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // final language =
                //     context.read<LanguageBloc>().state.selectedLanguage ==
                //             Language.english
                //         ? Language.malayalam
                //         : Language.english;
                // context
                //     .read<LanguageBloc>()
                //     .add(ChangeLanguage(selectedLanguage: language));
              },
              child: Text("AppLocalizations.of(context)!.changelanguage"),
            )
          ],
        ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // SignUpLogoWidget(),
                      // SignUpTextFormFieldsWidgets(),
                      // SignUpButtonWidget(),
                    ],
                  ),
                ),
              ),
            ),
            // SignUpBottomWidget(),
          ],
        ),
      ),
    );
  }
}
