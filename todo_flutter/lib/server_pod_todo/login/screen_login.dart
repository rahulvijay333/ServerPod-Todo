import 'package:flutter/material.dart';
import 'package:serverpod_auth_email_flutter/serverpod_auth_email_flutter.dart';
import 'package:todo_flutter/src/session_manager.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
      backgroundColor: Colors.blue,
        title: Text('Login',style: TextStyle(fontSize: 16,color: Colors.white),),
      ),

      body:  Center(child: SignInWithEmailButton(caller: client!.modules.auth,)),
    );
  }
}
