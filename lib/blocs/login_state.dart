part of 'login_bloc.dart';

@immutable

abstract class LoginState {}

class LoginStateInitial extends LoginState {}

class BrukerNavnFinnesState extends LoginState{}

class OpprettBrukerNavnState extends LoginState{}

