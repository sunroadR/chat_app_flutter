part of 'chatside_bloc.dart';

@immutable
abstract class ChatsideEvent {}

class OpenForSearch extends ChatsideEvent{}

class FinnesBruker extends ChatsideEvent{
  final String _brukerNavn;

  FinnesBruker(this._brukerNavn);

  String get brukerNavn => _brukerNavn;
}

class SendMelding extends ChatsideEvent{
  final String _melding;
  final String _motakersNavn;

  SendMelding(this._melding,this._motakersNavn);

  String get melding => _melding;
  String get motakersNavn => _motakersNavn;
}


