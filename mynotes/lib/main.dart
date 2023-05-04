import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/views/login_view.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      ),
    );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'),
      ),
      body: FutureBuilder(
        future:  Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
          ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState){
            case ConnectionState.done:
            // final user =FirebaseAuth.instance.currentUser;
            // //final emailVerified= user?.emailVerified ?? false;
            // if (user?.emailVerified ?? false){}
            // else{return const verifyEmailView();}
            
            // return const Text('Done');
              return const LoginView();
            default:
            return const Text('Loading...');
              }
        },
      )
    );
  }}
class verifyEmailView extends StatefulWidget {
  const verifyEmailView({super.key});

  @override
  State<verifyEmailView> createState() => _verifyEmailViewState();
}

class _verifyEmailViewState extends State<verifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return  Column(children:[
        const Text('Please verify your email address:'),
        TextButton(onPressed: () async{
          final user = FirebaseAuth.instance.currentUser;
          await user?.sendEmailVerification();
        },
         child: const Text ('Send email verification'),
         )
      ]
      );
  }
}