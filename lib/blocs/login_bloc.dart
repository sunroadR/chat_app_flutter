import 'dart:async';
import "package:bloc/bloc.dart";
import 'package:chat_app_flutter/resources/firestore_repository.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  FirestoreProvider _firestoreProvider = FirestoreProvider();

  LoginBloc(LoginStateInitial initialState) : super(initialState);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event,) async* {
    if (event is StartOppApp) {
      yield* _startOppApp(event);
    }
    if (event is OppretterBrukerNavn) {
      yield* _BrukerOpprettet(event);
    }
  }

  Stream<LoginState> _BrukerOpprettet(OppretterBrukerNavn event) async* {
    var finnes = await _firestoreProvider.brukerNavnFinnes(event.brukerNavn);
    if (finnes == false) {
      await _firestoreProvider.registrerBruker(event.brukerNavn);
      yield OpprettBrukerNavnState();
    }
    else if (finnes == true) {
      yield BrukerNavnFinnesState();
    }
  }

  Stream<LoginState> _startOppApp(StartOppApp event) async* {
    print('Hei og hopp!!!');
    var finnesBrukerId = await _firestoreProvider.finnesBrukerId();
    print(finnesBrukerId);
    if (finnesBrukerId == false) {

      yield BrukerErNy();
    }
    if (finnesBrukerId==true) {
      print('Hei på deg !!');
      yield BrukerHarBrukerId();
    }
  }
}


