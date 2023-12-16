import 'dart:async';

import 'package:e_commerce_universal/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

// this method does not need any permission

var users = {
  'demo@gmail.com': '1234',
  'patrick8q@gmail.com': 'YOUTAP2019',
  'yoneclick@gmail.com': 'Junio020499',
  'erick@gmail.com': 'erick123',
};

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  Duration get loginTime => const Duration(milliseconds: 750);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Esta conta não existe';
      }
      if (users[data.name] != data.password) {
        return 'Senha errada';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    users[data.name.toString()] = data.password.toString();
    print(users);
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Esta conta não existe';
      }
      return '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogin(
        navigateBackAfterRecovery: true,
        onLogin: _authUser,
        onRecoverPassword: _recoverPassword,
        onSignup: _signupUser,
        onSubmitAnimationCompleted: () => {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage(),
          ))
        },
        theme: LoginTheme(
          switchAuthTextColor: Colors.black,
          inputTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey.shade200,
            errorStyle: const TextStyle(
              color: Colors.red,
            ),
            labelStyle: const TextStyle(fontSize: 12, color: Colors.black),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(25)),
            focusedErrorBorder:
                OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(25)),
            disabledBorder:
                OutlineInputBorder(borderSide: const BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ),
    );
  }
}
