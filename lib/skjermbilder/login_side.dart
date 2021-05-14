import 'package:chat_app_flutter/blocs/login_bloc.dart';
import 'package:chat_app_flutter/skjermbilder/chat_side.dart';
import 'package:chat_app_flutter/skjermbilder/ui/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Side hvor man registrerer seg første gang med brukernavn.
class LoginSide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ChatApp'),
        ),
        body: BlocListener<LoginBloc, LoginState>(listener: (context, state) {
          if (state is BrukerNavnFinnesState) {
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: const Text('Brukernavnet er allerde i bruk',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20
              ),),
            ));
          }
        },
            child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          if (state is LoginStateInitial) {
            BlocProvider.of<LoginBloc>(context).add(StartOppApp());

          }
          if (state is BrukerHarBrukerId) {
            Future.delayed(Duration.zero, () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ChatSide()));
            });
          }
          if (state is BrukerErNy) {
            return LoginForm();
          }
          if (state is OpprettBrukerNavnState) {
            Future.delayed(Duration.zero, () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ChatSide()));
            });
          } else if (state is BrukerNavnFinnesState) {
            return LoginForm();
          }
          return Container();
        })));
  }
}
