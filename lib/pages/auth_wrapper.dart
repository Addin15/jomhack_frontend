import 'package:flutter/material.dart';
import 'package:jomhack/models/user.dart';
import 'package:jomhack/pages/auth/login.dart';
import 'package:jomhack/services/auth_service.dart';
import 'package:provider/provider.dart';

import 'nav.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, auth, child) {
        XUser? user = auth.user;

        if (user == null) {
          return const Login();
        } else {
          return const Nav();
        }
      },
    );
  }
}
