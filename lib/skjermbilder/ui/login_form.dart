import 'package:chat_app_flutter/blocs/login_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Tekstfelt for å registrere brukernavn
class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: ListView(
       // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _NyBruker(),
        ],
      ),
    );
  }
}

class _NyBruker extends StatefulWidget {
  @override
  __NyBrukerState createState() => __NyBrukerState();
}

class __NyBrukerState extends State<_NyBruker> {
  final _myController = TextEditingController();

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return ClipRect(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Container(
                alignment: Alignment.center,
                height: 200,
                width: 300,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.lime[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.all(20),
                  color: Colors.lime[50],
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Opprett brukernavn ',
                      ),
                      controller: _myController,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30),
                ),
                child: Text('Opprett bruker'),
                textColor: Colors.black,
                color: Colors.lightGreen,
                onPressed: () {
                  BlocProvider.of<LoginBloc>(context)
                      .add(OppretterBrukerNavn(_myController.text));
                }),
          ],
        ),
      );
    });
  }
}
