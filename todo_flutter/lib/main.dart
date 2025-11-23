import 'package:flutter/material.dart';
import 'package:todo_flutter/login/screen_login.dart';
import 'package:todo_flutter/src/session_manager.dart';

import 'home/screen_home.dart';

/// Sets up a global client object that can be used to talk to the server from
/// anywhere in our app. The client is generated from your server code
/// and is set up to connect to a Serverpod running on a local server on
/// the default port. You will need to modify this to connect to staging or
/// production servers.
/// In a larger app, you may want to use the dependency injection of your choice
/// instead of using a global client object. This is just a simple example.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeSessionManager();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sessionManager.addListener(
      () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Serverpod Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: sessionManager.isSignedIn ? ScreenHome() : ScreenLogin());
  }
}
