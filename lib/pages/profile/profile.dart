import 'package:flutter/material.dart';
import 'package:jomhack/services/auth_service.dart';
import 'package:jomhack/templates/custom_widgets.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: customTextButton(
        label: 'Logout',
        onPressed: () {
          AuthService auth = Provider.of(context, listen: false);
          auth.logout();
        },
      ),
    );
  }
}
