import 'package:e_commerce_universal/pages/authentication_page.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.grey.shade300,
        primaryColorDark: Colors.indigo.shade900,
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo)),
        colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: Colors.indigo,
            onPrimary: Colors.indigo.shade200,
            surface: Colors.black,
            onSurface: Colors.black,
            secondary: Colors.white,
            onSecondary: Colors.grey.shade300,
            background: Colors.grey.shade300,
            onBackground: Colors.grey.shade300,
            error: Colors.red,
            onError: Colors.red),
        textTheme: const TextTheme(
          headline3: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 45.0,
            color: Colors.orange,
          ),
          button: TextStyle(fontFamily: 'OpenSans', color: Colors.green),
          subtitle1: TextStyle(fontFamily: 'NotoSans'),
          bodyText2: TextStyle(fontFamily: 'NotoSans'),
        ),
      ),
      home: const AuthenticationPage(),
    );
  }
}
