import 'package:flutter/material.dart';
import 'package:jomhack/services/auth_service.dart';
import 'package:jomhack/templates/custom_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../themes/colors.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of(context, listen: false);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          key: _formKey,
          body: Form(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  customTextFormField(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    hintText: 'Email',
                    validator: (text) =>
                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(text!)
                            ? null
                            : 'Email is not valid',
                  ),
                  SizedBox(height: 1.h),
                  customTextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    hintText: 'Password',
                    isObscured: true,
                    validator: (text) {
                      if (text == null || text.isEmpty || text.length < 6) {
                        return 'Password should be at least 6 characters';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: customTextButton(
                          label: 'Register',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Register()));
                          },
                          backgroundColor: AppColor.secondary,
                        ),
                      ),
                      SizedBox(width: 1.5.w),
                      Expanded(
                        child: customTextButton(
                          label: 'Login',
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            auth.login(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
