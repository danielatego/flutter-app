import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_a/components/app_bar.dart';
import 'package:two_a/components/mediaquery.dart';
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
    var media = MQuery(context: context);
    final sf = media.heightscalefactor();
    final wf = media.widthScalefactor();
    final mf = media.heigthmarginfactor();

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
        appBar: CustomAppbar(
          context: context,
          locTitle: context.loc.login,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(0, (36 * mf), 0, 0),
            child: Column(
              children: [
                Image.asset(
                  'images/logo/logo.png',
                  height: 64 * sf,
                  width: 64 * sf,
                  fit: BoxFit.cover,
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, (mf * 16))),
                Text(
                  context.loc.while_we_can,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: (16 * wf),
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, (mf * 120))),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 68 * wf,
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
                    maxLines: 1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 14 * sf, horizontal: 11 * wf),
                      border: OutlineInputBorder(
                        gapPadding: 0.0,
                        borderSide: const BorderSide(
                          color: Color(0XFF838383),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8 * sf)),
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
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, (mf * 24))),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 68 * wf,
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
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 14 * sf, horizontal: 11 * wf),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0XFF838383),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8 * sf)),
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
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, (mf * 24))),
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
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, (mf * 120))),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16 * wf),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () async {
                            context.read<AuthBloc>().add(
                                  const AuthEventShouldRegister(),
                                );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xff838383),
                            textStyle: (Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  fontSize: 16 * wf,
                                )),
                          ),
                          child: Text(context.loc.sign_up_instead),
                        ),
                        TextButton(
                          onPressed: () async {
                            context.read<AuthBloc>().add(
                                  const AuthEventForgotPassword(null),
                                );
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xff838383),
                            textStyle: (Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  fontSize: 16 * wf,
                                )),
                          ),
                          child: Text(context.loc.forgot_password),
                        )
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
