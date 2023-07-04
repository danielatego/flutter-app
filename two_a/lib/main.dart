import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:two_a/extensions/buildcontext/loc.dart';
import 'package:two_a/firebase/authentication/fireauth.dart';
import 'package:two_a/firebase/authentication/provider.dart';
import 'package:two_a/firebase/bloc/auth_bloc.dart';
import 'package:two_a/firebase/bloc/auth_event.dart';
import 'package:two_a/firebase/bloc/auth_state.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

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
        if (state.isLoading) {}
      },
      builder: (context, state) {},
    );
  }
}
// return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         body: Center(
//           child: Text(context.loc.helloWorld),
//         ),
//       ),
//     );