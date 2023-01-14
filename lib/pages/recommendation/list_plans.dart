import 'package:flutter/material.dart';
import 'package:jomhack/models/plan.dart';
import 'package:sizer/sizer.dart';

import '../../themes/colors.dart';

class ListPlans extends StatefulWidget {
  const ListPlans({super.key, required this.plans});

  final List<PlanModel> plans;

  @override
  State<ListPlans> createState() => _ListPlansState();
}

class _ListPlansState extends State<ListPlans> {
  @override
  Widget build(BuildContext context) {
    return widget.plans.isEmpty
        ? const Center(
            child: Text('No plan available'),
          )
        : ListView.separated(
            itemBuilder: (context, index) {
              PlanModel plan = widget.plans[index];
              return Card(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                borderRadius: BorderRadius.circular(3.sp),
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
                                        color: AppColor.secondary,
                                        fontWeight: FontWeight.w400,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                    child: const VerticalDivider(
                                      width: 1,
                                      thickness: 1,
                                      color: AppColor.primary,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      plan.provider!.name.toString(),
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: AppColor.secondary,
                                        fontWeight: FontWeight.w700,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.sp),
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
                                        color: AppColor.secondary,
                                        fontWeight: FontWeight.w400,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                    child: const VerticalDivider(
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
                                        color: AppColor.secondary,
                                        fontWeight: FontWeight.w700,
                                        overflow: TextOverflow.ellipsis,
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
              );
            },
            separatorBuilder: (context, index) {
              if (index < widget.plans.length) {
                return SizedBox(height: 1.h);
              }

              return const SizedBox.shrink();
            },
            itemCount: widget.plans.length,
          );
  }
}
