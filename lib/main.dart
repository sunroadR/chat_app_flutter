

import 'package:chat_app_flutter/blocs/login_bloc.dart';
import 'package:chat_app_flutter/blocs/chatside_bloc.dart';
import 'package:chat_app_flutter/skjermbilder/login_side.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

 Future<void>main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await  Firebase.initializeApp();
   runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initializing = Firebase.initializeApp();
    return FutureBuilder(
        future: _initializing,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Noe gikk galt');
          }
          if (snapshot.connectionState == ConnectionState.done) {

            return MultiBlocProvider(
                providers:[
                  BlocProvider<LoginBloc>(
                    create: (BuildContext context) => LoginBloc(LoginStateInitial())
                  ),
                  BlocProvider<ChatsideBloc>(
                    create: (BuildContext context)=>ChatsideBloc(ChatsideInitialState())
                  ),
                ],

                child: MaterialApp(
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    primarySwatch: Colors.lightGreen,
                  ),

                   home: LoginSide(),
                )
            );
          }
          return Center(child: CircularProgressIndicator(),);
        }
    );
  }
}

