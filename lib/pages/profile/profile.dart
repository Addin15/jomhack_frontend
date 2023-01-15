import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jomhack/config/api.dart';
import 'package:jomhack/pages/assestment_page.dart';
import 'package:jomhack/pages/profile/edit_profile.dart';
import 'package:jomhack/themes/colors.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../models/user.dart';
import '../../services/auth_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context, listen: false);
    XUser user = auth.user!;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35.sp,
            backgroundColor: AppColor.tertiary,
            child: user.image == null
                ? Icon(
                    Ionicons.person,
                    size: 35.sp,
                  )
                : ClipOval(child: Image.network('$baseURLMedia${user.image}')),
          ),
          SizedBox(height: 1.5.h),
          Text(
            user.name.toString(),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.tertiary,
            ),
          ),
          SizedBox(height: 2.h),
          buildSetting([
            Setting(
              icon: Ionicons.pencil,
              label: 'Edit Profile',
              color: Colors.blueAccent,
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => EditProfile(user: user),
                  ),
                );
              },
            ),
            Setting(
              icon: Ionicons.document_text_outline,
              label: 'Assestment',
              color: Colors.orange,
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        leading: const BackButton(color: AppColor.tertiary),
                        elevation: 0,
                        backgroundColor: AppColor.background,
                        centerTitle: true,
                        title: Text(
                          'Assestment',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.tertiary,
                          ),
                        ),
                      ),
                      body: const AssestmentPage(),
                    ),
                  ),
                );
              },
            ),
          ]),
          SizedBox(height: 2.h),
          buildSetting([
            Setting(
              icon: Ionicons.help_outline,
              label: 'FAQs',
              color: Colors.indigo,
              onTap: () {},
            ),
            Setting(
              icon: Ionicons.information_outline,
              label: 'Privacy & Policy',
              color: Colors.cyan,
              onTap: () {},
            ),
          ]),
          SizedBox(height: 5.h),
          buildSetting([
            Setting(
              icon: Ionicons.log_out_outline,
              label: 'Logout',
              color: Colors.red,
              onTap: () {
                auth.logout();
              },
            ),
          ]),
        ],
      ),
    );
  }

  Widget buildSetting(List<Setting> settings) => Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.sp),
          color: AppColor.background,
        ),
        child: Column(
          children: [
            ...settings.map((s) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: s.onTap,
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(3.sp),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.sp),
                            color: s.color,
                          ),
                          child: Icon(
                            s.icon,
                            size: 15.sp,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Expanded(child: Text(s.label)),
                        Icon(
                          Ionicons.chevron_forward_outline,
                          size: 10.sp,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  settings.last != s
                      ? const Divider(color: AppColor.primary)
                      : const SizedBox.shrink(),
                ],
              );
            }).toList()
          ],
        ),
      );
}

class Setting {
  final IconData icon;
  final String label;
  final Function()? onTap;
  final Color color;

  Setting({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.color,
  });
}
