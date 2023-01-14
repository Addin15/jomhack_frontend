import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jomhack/models/plan.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../themes/colors.dart';

class ViewPlan extends StatelessWidget {
  const ViewPlan({
    super.key,
    required this.plan,
  });

  final PlanModel plan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: AppColor.tertiary),
        elevation: 0,
        backgroundColor: AppColor.background,
        centerTitle: true,
        // title: Text(
        //   plan.name.toString(),
        //   style: TextStyle(
        //     fontSize: 14.sp,
        //     fontWeight: FontWeight.bold,
        //     color: AppColor.tertiary,
        //   ),
        // ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        width: 100.w,
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Text(
              plan.name.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.tertiary,
              ),
            ),
            SizedBox(height: 1.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.sp),
                color: Colors.white,
              ),
              child: Text(
                plan.about.toString(),
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'Provider',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.tertiary,
              ),
            ),
            SizedBox(height: 1.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.sp),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.sp),
                      child: Image.network(
                        plan.provider!.logo.toString(),
                        fit: BoxFit.fitWidth,
                        width: 50.w,
                      ),
                    ),
                  ),
                  const Divider(
                    color: AppColor.primary,
                    height: 1,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: plan.provider!.phone == null
                            ? null
                            : () async {
                                final Uri phoneUri =
                                    Uri.parse('tel:${plan.provider!.phone}');

                                if (await canLaunchUrl(phoneUri)) {
                                  launchUrl(phoneUri);
                                }
                              },
                        icon: Icon(
                          Ionicons.call,
                          size: 15.sp,
                          color: plan.provider!.phone == null
                              ? Colors.grey.shade400
                              : AppColor.tertiary,
                        ),
                      ),
                      IconButton(
                        onPressed: plan.provider!.email == null
                            ? null
                            : () async {
                                final Uri emailUrl =
                                    Uri.parse('mailto:${plan.provider!.email}');

                                if (await canLaunchUrl(emailUrl)) {
                                  launchUrl(emailUrl);
                                }
                              },
                        icon: Icon(
                          Ionicons.mail,
                          size: 15.sp,
                          color: plan.provider!.email == null
                              ? Colors.grey.shade400
                              : AppColor.tertiary,
                        ),
                      ),
                      IconButton(
                        onPressed: plan.provider!.website == null
                            ? null
                            : () async {
                                final Uri websiteUrl =
                                    Uri.parse('${plan.provider!.website}');

                                if (await canLaunchUrl(websiteUrl)) {
                                  launchUrl(websiteUrl);
                                }
                              },
                        icon: Icon(
                          Ionicons.globe,
                          size: 15.sp,
                          color: plan.provider!.website == null
                              ? Colors.grey.shade400
                              : AppColor.tertiary,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: AppColor.primary,
                    height: 1,
                    thickness: 1,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    child: Text(
                      plan.provider!.about.toString(),
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
