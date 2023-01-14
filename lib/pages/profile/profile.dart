import 'package:flutter/material.dart';
import 'package:jomhack/services/auth_service.dart';
import 'package:jomhack/templates/custom_widgets.dart';
import 'package:provider/provider.dart';

import '../../models/provider.dart';
import '../../models/user.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  ProviderModel? a;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          customTextButton(
            label: 'Logout',
            onPressed: () {
              AuthService auth = Provider.of(context, listen: false);
              auth.logout();
            },
          ),
        ],
      ),
    );
  }
}
