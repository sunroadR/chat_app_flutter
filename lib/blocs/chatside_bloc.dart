import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app_flutter/resources/firestore_repository.dart';
import 'package:meta/meta.dart';

part 'chatside_event.dart';
part 'chatside_state.dart';

class ChatsideBloc extends Bloc<ChatsideEvent, ChatsideState> {
  FirestoreProvider _firestoreProvider = FirestoreProvider();

  ChatsideBloc(ChatsideInitialState initialState)
      : super(ChatsideInitialState());

  @override
  Stream<ChatsideState> mapEventToState(ChatsideEvent event,) async* {
    if (event is OpenForSearch) {
      yield SearchFieldOpen();
    }
    if (event is FinnesBruker)
      yield* _FinnesBruker(event);
    if(event is SendMelding ){
      yield* sendNyMelding(event);
    }
  }

  Stream<ChatsideState> _FinnesBruker(FinnesBruker event) async* {
    var finnes = await _firestoreProvider.brukerNavnFinnes(event.brukerNavn);

    if (finnes == false) {
      yield BrukerFinnesIkkeState();
    }
    else if (finnes == true) {
      yield SnakkeMedState(event.brukerNavn);
    }
  }

  Stream<ChatsideState> sendNyMelding(SendMelding event) async* {
    _firestoreProvider.sendMelding(event.motakersNavn,event.melding);

    yield MeldingSendtState(event.motakersNavn, event.melding);
  }
}


