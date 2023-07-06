import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:two_a/extensions/buildcontext/loc.dart';
import 'package:two_a/firebase/authentication/exceptions.dart';
import 'package:two_a/firebase/bloc/auth_bloc.dart';
import 'package:two_a/firebase/bloc/auth_state.dart';
import 'package:two_a/utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sf = MediaQuery.of(context).size.height / 667;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException ||
              state.exception is WrongDetailsAuthException) {
            await showErrorDialog(
                context, context.loc.login_error_cannot_find_user);
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(
              context,
              context.loc.login_error_wrong_credentials,
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: (36 * sf),
          title: Text(
            context.loc.login,
            style: Theme.of(context).textTheme.titleMedium,
            textScaleFactor: sf,
          ),
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          padding: EdgeInsets.fromLTRB(0, (36 * sf), 0, 0),
          child: SvgPicture.asset(
            'images/logo.svg',
            semanticsLabel: 'My SVG Image',
            height: 64 * sf,
          ),
        ),
      ),
    );
  }
}
