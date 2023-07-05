import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:two_a/firebase/authentication/fireauth.dart';
import 'package:two_a/firebase/bloc/auth_bloc.dart';
import 'package:two_a/firebase/bloc/auth_event.dart';
import 'package:two_a/firebase/bloc/auth_state.dart';
import 'package:two_a/helpers/loading/loading_screen.dart';
import 'package:two_a/views/forgot_password_view.dart';
import 'package:two_a/views/homepage_view.dart';
import 'package:two_a/views/login_view.dart';
import 'package:two_a/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
        title: '2A',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0XFFF5F5F5),
          fontFamily: 'Roboto',
        ),
        home: BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(FireAuth()),
          child: const HomePage2A(),
        )),
  );
}

class HomePage2A extends StatelessWidget {
  const HomePage2A({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
              context: context,
              text: state.loadingText ?? "Please wait a moment");
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const HomeView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
