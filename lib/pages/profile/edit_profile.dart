import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jomhack/models/user.dart';
import 'package:jomhack/services/api_service.dart';
import 'package:jomhack/services/auth_service.dart';
import 'package:jomhack/templates/custom_widgets.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../themes/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    super.key,
    required this.user,
  });

  final XUser user;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _nameController;
  final FocusNode _nameFocus = FocusNode();

  bool unchanged = true;
  bool isSaving = false;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.user.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              leading: const BackButton(color: AppColor.tertiary),
              elevation: 0,
              backgroundColor: AppColor.background,
              centerTitle: true,
              title: Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.tertiary,
                ),
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customTextFormField(
                    controller: _nameController,
                    focusNode: _nameFocus,
                    hintText: 'Name',
                    validator: (text) => text == null || text.isEmpty
                        ? 'Name can\'t be empty'
                        : null,
                    onChanged: (val) {
                      setState(() {
                        unchanged = false;
                      });
                    },
                  ),
                  SizedBox(height: 2.h),
                  customTextButton(
                    label: 'Save',
                    backgroundColor:
                        unchanged ? Colors.grey : AppColor.tertiary,
                    onPressed: unchanged
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              isSaving = true;
                            });

                            AuthService auth =
                                Provider.of(context, listen: false);
                            bool res =
                                await auth.edit(name: _nameController.text);

                            if (res) {
                              setState(() {
                                isSaving = false;
                                unchanged = true;
                                widget.user.name = _nameController.text;
                              });
                            } else {
                              setState(() {
                                isSaving = false;
                              });
                            }
                          },
                  ),
                ],
              ),
            ),
          ),
        ),
        isSaving
            ? Container(
                alignment: Alignment.center,
                color: AppColor.background,
                child: SpinKitFadingCube(
                  color: AppColor.tertiary,
                  size: 30.sp,
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
