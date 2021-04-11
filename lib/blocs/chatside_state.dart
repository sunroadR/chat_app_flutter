part of 'chatside_bloc.dart';

@immutable
abstract class ChatsideState {}

class ChatsideInitialState extends ChatsideState {}

class SearchFieldOpen extends ChatsideState{}

class BrukerFinnesIkkeState extends ChatsideState{}

class SnakkeMedState extends ChatsideState{
  final String _mottakersNavn;

  SnakkeMedState(this._mottakersNavn);

  String get mottakersNavn => _mottakersNavn;
}

class MeldingSendtState extends ChatsideState{
  final String _mottakersNavn;
  final String _melding;

  MeldingSendtState (this._mottakersNavn,this._melding);

  String get mottakersNavn => _mottakersNavn;
  String get melding => _melding;
}

