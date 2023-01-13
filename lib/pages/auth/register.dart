import 'package:flutter/material.dart';
import 'package:jomhack/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../templates/custom_widgets.dart';
import '../../themes/colors.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context, listen: false);
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
                    'Register',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  customTextFormField(
                    controller: _nameController,
                    focusNode: _nameFocus,
                    hintText: 'Name',
                    validator: (text) => text == null || text.isEmpty
                        ? 'Name can\'t be empty'
                        : null,
                  ),
                  SizedBox(height: 1.h),
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
                    validator: (text) {
                      if (text == null || text.isEmpty || text.length < 6) {
                        return 'Password should be at least 6 characters';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 1.h),
                  customTextFormField(
                    controller: _confirmPasswordController,
                    focusNode: _confirmPasswordFocus,
                    hintText: 'Confirm Password',
                    validator: (text) =>
                        text.toString() == _passwordController.text
                            ? null
                            : 'Password doesn\'t match',
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: customTextButton(
                          label: 'Login',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          backgroundColor: AppColor.secondary,
                        ),
                      ),
                      SizedBox(width: 1.5.w),
                      Expanded(
                        child: customTextButton(
                          label: 'Register',
                          onPressed: () async {
                            String? res = await auth.register(
                              name: _nameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            if (res == null) {
                              if (mounted) {
                                Navigator.pop(context);
                              }
                            }
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
