import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/firebase_options.dart';
import 'views/login_view.dart';
import 'views/register_view.dart';
import 'views/veriry_email_view.dart';void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        loginRoute:(context)=> const LoginView(),
        registerRoute:(context)=> const RegisterView(),
        verifyEmailRoute:(context) => const VerifyEmailView(),
        notesRoute:(context) => const NotesView(),
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
          PopupMenuButton<Menu>(
            onSelected: (value) async{
            switch (value){
              
              case Menu.logout:
                final shouldLogout = await showlogOutDialog(context);
                if (shouldLogout){
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute, 
                    (_) => false,
                    );
                }
                break;
              case Menu.login:
                break;
            }
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
Future <bool>showlogOutDialog(BuildContext context){
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text ('Are you sure you want to sign out'),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.of(context).pop(false);
            }, 
            child: const Text ('Cancel')
            ),
            TextButton(
            onPressed: (){
              Navigator.of(context).pop(true);
            }, 
            child: const Text ('Log out')
            )
        ],
      );
    },
    
    ). then((value)=>value ?? false );
}