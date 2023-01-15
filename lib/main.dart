import 'package:flutter/material.dart';
import 'package:jomhack/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'pages/auth_wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(create: (context) => AuthService()),
      ],
      builder: (context, child) {
        return Sizer(builder: (context, orientation, deviceType) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'RHB JomHack',
            home: AuthWrapper(),
          );
        });
      },
    );
  }
}
