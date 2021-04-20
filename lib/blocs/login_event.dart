part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class OppretterBrukerNavn  extends LoginEvent {

  final String _brukerNavn;

  OppretterBrukerNavn(this._brukerNavn);

  String get brukerNavn => _brukerNavn;
}

class StartOppApp extends LoginEvent{

}

