// lib/widgets/login_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc.dart';
import 'home_page.dart'; // เพิ่มการนำเข้า HomePage

class LoginForm extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController regionController = TextEditingController();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: usernameController,
          decoration: const InputDecoration(labelText: 'Username'),
        ),
        TextField(
          controller: regionController,
          decoration: const InputDecoration(labelText: 'Region'),
        ),
        const SizedBox(height: 20),
        BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              // นำทางไปยัง HomePage หลังจากล็อกอินสำเร็จ
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(username: state.user.username),
                ),
              );
            }
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Failed: ${state.error}')));
            }
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              return const CircularProgressIndicator();
            }
            return ElevatedButton(
              onPressed: () {
                final username = usernameController.text;
                final region = regionController.text;
                BlocProvider.of<LoginBloc>(context).add(LoginSubmitted(username: username, region: region));
              },
              child: const Text('Login'),
            );
          },
        ),
      ],
    );
  }
}
