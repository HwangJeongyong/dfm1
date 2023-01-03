import 'package:dfm1/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:dfm1/screens/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override

  late bool isAutologin;

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _loadAutologin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isAutologin = pref.getBool('Autologin') ?? false;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatting app',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MainScreen();
          }
          return LoginSignupScreen();
        },
      ),
    );
  }
}
