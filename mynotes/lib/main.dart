import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';
import 'views/login_view.dart';
import 'views/register_view.dart';
import 'dart:developer';
import 'views/veriry_email_view.dart';void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/login/':(context)=> const LoginView(),
        '/register/':(context)=> const RegisterView(),
        '/verify/':(context) => const VerifyEmailView(),
      },
      ),
    );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:  Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
          ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState){
            case ConnectionState.done:
            final user =FirebaseAuth.instance.currentUser;
            if (user!=null){
              if (user.emailVerified){
                return const NotesView();
              }
              else{
                return const VerifyEmailView();
              }
            }
            else {
              return const LoginView(); 
            }
            default:
            return const CircularProgressIndicator();
              }
        },
      );
  }}

enum Menu{ logout ,login}

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<Menu>(onSelected: (value){
            print(value);
          },
          itemBuilder: (context) {
            return const [
               PopupMenuItem<Menu>(
                value: Menu.logout,
                child: Text ('logout')),
                PopupMenuItem<Menu>(
                value: Menu.login,
                child: Text ('login')),
            ];
          },
          
          )
        
        ],
      ),
      body: const Text('Hello World'),
    );
  }
}