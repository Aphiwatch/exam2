// lib/bloc/login_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test1/Model/user_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      try {
        final user =
            await login(event.username, event.region); // รับ User เดียว
        emit(LoginSuccess(user)); // ส่ง User เดียวไปยัง LoginSuccess
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }

  Future<User> login(String username, String region) async {
  final response = await http.post(
    Uri.parse('https://run.mocky.io/v3/851a53e4-c7eb-4793-9b53-64f9b32d020a'),
    body: json.encode({
      'username': username,
      'region': region,
    }),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    if (data is List) {
      // ค้นหาผู้ใช้ที่ตรงกับ username และ region
      final user = data.firstWhere(
        (item) => item['username'] == username && item['region'] == region,
        orElse: () => null, // ถ้าไม่เจอจะคืนค่า null
      );

      if (user != null) {
        return User.fromJson(user); // คืนค่า User ที่ตรงกัน
      } else {
        throw Exception('User not found');
      }
    } else {
      throw Exception('Unexpected data format: Not a List');
    }
  } else {
    throw Exception('Failed to login');
  }

}

}
