// lib/bloc/login_event.dart
part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String username;
  final String region;

  LoginSubmitted({required this.username, required this.region});
}

