import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/validations.dart';
import '../../../../core/widgets/app_textform_field.dart';
import '../bloc/signin_bloc.dart';
import '../bloc/signin_event.dart';
import '../bloc/signin_state.dart';

class SignInTextFieldWidget extends StatelessWidget {
  const SignInTextFieldWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninBloc, SigninState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            AppTextFormFieldWidget(
              text: "email",
              onChanged: (value) {
                context.read<SigninBloc>().add(EmailChangedSignin(value));
              },
              validator: isValidEmail,
              autovalidateMode:
                  context.read<SigninBloc>().state.showErrorMessage
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
            ),
            const SizedBox(height: 10),
            AppTextFormFieldWidget(
              text: "password",
              onChanged: (value) {
                context.read<SigninBloc>().add(PasswordChangedSignin(value));
              },
              validator: isPasswordValid,
              autovalidateMode:
                  context.read<SigninBloc>().state.showErrorMessage
                      ? AutovalidateMode.always
                      : AutovalidateMode.disabled,
            ),
          ],
        );
      },
    );
  }
}
