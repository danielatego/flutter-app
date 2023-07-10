import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_a/extensions/buildcontext/loc.dart';
import 'package:two_a/firebase/authentication/exceptions.dart';
import 'package:two_a/firebase/bloc/auth_bloc.dart';
import 'package:two_a/firebase/bloc/auth_event.dart';
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
    final wf = MediaQuery.of(context).size.width / 375;
    print(sf);
    print(wf);
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
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            padding: EdgeInsets.fromLTRB(0, (36 * sf), 0, 0),
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/logo/logo.png',
                      height: 64 * sf,
                      width: 64 * sf,
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, (sf * 16))),
                    Text(
                      context.loc.while_we_can,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: (16 * wf),
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, (sf * 117))),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 48 * wf,
                        vertical: 0,
                      ),
                      child: TextField(
                        controller: _email,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            fontSize: 16 * wf,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            gapPadding: 0.0,
                            borderSide: const BorderSide(
                              color: Color(0XFF838383),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8 * sf)),
                          ),
                          hintText: context.loc.email_text_field_placeholder,
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: (16 * wf),
                            color: const Color(0XFF808080),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, (sf * 24))),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 48 * wf,
                        vertical: 0,
                      ),
                      child: TextField(
                        controller: _password,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(
                            fontSize: 16 * wf,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0XFF838383),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8 * sf)),
                          ),
                          hintText: context.loc.password_text_field_placeholder,
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: (16 * wf),
                            color: const Color(0XFF808080),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, (sf * 24))),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 48 * wf,
                        vertical: 0,
                      ),
                      child: FilledButton(
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;
                          context.read<AuthBloc>().add(
                                AuthEventLogin(
                                  email,
                                  password,
                                ),
                              );
                        },
                        style: FilledButton.styleFrom(
                            alignment: Alignment.center,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8 * wf)),
                            fixedSize: Size(240 * wf, 40 * sf),
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: (20 * wf),
                            )),
                        child: Text(context.loc.login),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
