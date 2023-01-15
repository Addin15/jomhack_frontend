import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jomhack/models/user.dart';
import 'package:jomhack/pages/assestment_page.dart';
import 'package:jomhack/services/auth_service.dart';
import 'package:jomhack/templates/custom_widgets.dart';
import 'package:jomhack/themes/colors.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isUploading = false;

  XFile? image;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColor.background,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Get',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.tertiary,
                ),
              ),
              Text(
                'Insured',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.tertiary,
                ),
              ),
            ],
          ),
        ),
        body: Consumer<AuthService>(
          builder: (context, auth, child) {
            XUser user = auth.user!;
            int active = user.image == null ? 0 : 1;
            _tabController.animateTo(active);

            return Column(
              children: [
                IconStepper(
                  activeStepColor: AppColor.tertiary,
                  enableNextPreviousButtons: false,
                  enableStepTapping: false,
                  stepRadius: 15.sp,
                  lineColor: AppColor.secondary,
                  activeStep: active,
                  onStepReached: (index) {},
                  icons: const [
                    Icon(
                      Ionicons.image_outline,
                      color: Colors.white,
                    ),
                    Icon(
                      Ionicons.document_text_outline,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: [
                      Stack(
                        fit: StackFit.expand,
                        children: [
                          uploadPhotoTab(auth),
                          isUploading
                              ? Container(
                                  alignment: Alignment.center,
                                  color: AppColor.background.withOpacity(0.3),
                                  child: SpinKitFadingCube(
                                    color: AppColor.tertiary,
                                    size: 30.sp,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                      AssestmentPage(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget uploadPhotoTab(AuthService auth) => Container(
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                ImagePicker imagePicker = ImagePicker();

                XFile? i =
                    await imagePicker.pickImage(source: ImageSource.gallery);

                if (i != null) {
                  setState(() {
                    image = i;
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.sp),
                  color: Colors.white,
                ),
                width: 90.w,
                height: 40.h,
                child: image == null
                    ? Icon(
                        Ionicons.image_outline,
                        size: 30.sp,
                        color: AppColor.tertiary,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(5.sp),
                        child: Image.file(
                          File(image!.path),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 2.h),
            customTextButton(
              label: 'Next',
              backgroundColor: image == null ? Colors.grey : AppColor.tertiary,
              onPressed: image == null
                  ? null
                  : () async {
                      setState(() {
                        isUploading = true;
                      });
                      if (image != null) {
                        await auth.uploadPhoto(image: File(image!.path));
                      }

                      setState(() {
                        isUploading = false;
                      });
                    },
            ),
            SizedBox(height: 1.h),
            customTextButton(
              label: 'Logout',
              backgroundColor: AppColor.tertiary,
              onPressed: () {
                auth.logout();
              },
            ),
          ],
        ),
      );
}
