import 'package:brianpharmacy/screens/admin/adminAuth/login.dart';
import 'package:brianpharmacy/screens/admin/adminAuth/signup.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) =>
  isLogin ? LoginPage(onClickedSignUp: toggle )
  : SignUp(onClickedSignUp: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}