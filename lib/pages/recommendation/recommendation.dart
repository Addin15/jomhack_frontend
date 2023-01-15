import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jomhack/models/plan.dart';
import 'package:jomhack/pages/recommendation/all_plans.dart';
import 'package:jomhack/pages/recommendation/view_plan.dart';
import 'package:jomhack/services/api_service.dart';
import 'package:sizer/sizer.dart';

import '../../themes/colors.dart';

class Recommendation extends StatefulWidget {
  const Recommendation({super.key});

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation>
    with AutomaticKeepAliveClientMixin {
  Future<List<PlanModel>> getUserPlans() async {
    return await APIService.getUserPlans();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      child: FutureBuilder(
          future: getUserPlans(),
          builder: (context, AsyncSnapshot<List<PlanModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SpinKitFadingCube(
                color: AppColor.tertiary,
                size: 30.sp,
              );
            }

            List<PlanModel> plans = snapshot.data ?? [];

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recommended plans for you',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.tertiary,
                      ),
                    ),
                    SizedBox(
                      height: 25.sp,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AllPlans()));
                        },
                        child: const Text(
                          'Browse',
                          style: TextStyle(
                            color: AppColor.secondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                plans.isEmpty
                    ? Container(
                        alignment: Alignment.center,
                        child: const Text('No plan available'),
                      )
                    : Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            PlanModel plan = plans[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewPlan(plan: plan),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.sp)),
                                child: Container(
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.sp),
                                    color: AppColor.primary,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 20.w,
                                        height: 12.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5.sp),
                                            bottomLeft: Radius.circular(5.sp),
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5.sp),
                                            bottomLeft: Radius.circular(5.sp),
                                          ),
                                          child: Image.network(
                                            plan.provider!.logo.toString(),
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 2.w,
                                          vertical: 1.h,
                                        ),
                                        width: 70.w,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              plan.name.toString(),
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: AppColor.tertiary,
                                                fontWeight: FontWeight.w700,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(height: 1.h),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3.sp),
                                                color: AppColor.background,
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 2.w,
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 15.w,
                                                    child: Text(
                                                      'Provider',
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color:
                                                            AppColor.secondary,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3.h,
                                                    child:
                                                        const VerticalDivider(
                                                      width: 1,
                                                      thickness: 1,
                                                      color: AppColor.primary,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      plan.provider!.name
                                                          .toString(),
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color:
                                                            AppColor.secondary,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 0.5.h),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3.sp),
                                                color: AppColor.background,
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 2.w,
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 15.w,
                                                    child: Text(
                                                      'Category',
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color:
                                                            AppColor.secondary,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3.h,
                                                    child:
                                                        const VerticalDivider(
                                                      width: 1,
                                                      thickness: 1,
                                                      color: AppColor.primary,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      plan.category.toString(),
                                                      textAlign: TextAlign.end,
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color:
                                                            AppColor.secondary,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            if (index < plans.length) {
                              return SizedBox(height: 1.h);
                            }
                            return const SizedBox.shrink();
                          },
                          itemCount: plans.length,
                        ),
                      ),
              ],
            );
          }),
    );
  }
}
