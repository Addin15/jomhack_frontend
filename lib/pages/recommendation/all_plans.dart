import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jomhack/pages/recommendation/list_plans.dart';
import 'package:jomhack/themes/colors.dart';
import 'package:sizer/sizer.dart';

import '../../models/plan.dart';
import '../../services/api_service.dart';

class AllPlans extends StatefulWidget {
  const AllPlans({super.key});

  @override
  State<AllPlans> createState() => _AllPlansState();
}

class _AllPlansState extends State<AllPlans> {
  int _selectedPage = 0;
  final PageController _pageController = PageController();

  List<PlanModel> plans = [];
  List<PlanModel> lifePlans = [];
  List<PlanModel> vehiclePlans = [];
  List<PlanModel> homePlans = [];

  bool isRetrieving = true;

  void getPlans() async {
    List<PlanModel> data = await APIService.getPlans();

    for (PlanModel plan in data) {
      if (plan.category
          .toString()
          .toLowerCase()
          .contains('Life'.toLowerCase())) {
        lifePlans.add(plan);
      } else if (plan.category
          .toString()
          .toLowerCase()
          .contains('Vehicle'.toLowerCase())) {
        vehiclePlans.add(plan);
      } else if (plan.category
          .toString()
          .toLowerCase()
          .contains('Home'.toLowerCase())) {
        homePlans.add(plan);
      }
    }

    setState(() {
      plans = data;
      isRetrieving = false;
    });
  }

  @override
  void initState() {
    getPlans();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: AppColor.tertiary),
        elevation: 0,
        backgroundColor: AppColor.background,
        centerTitle: true,
        title: Text(
          'All Plans',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.tertiary,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        child: isRetrieving
            ? SpinKitFadingCube(
                color: AppColor.tertiary,
                size: 30.sp,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        selectButton(
                          onTap: () {
                            setState(() {
                              _selectedPage = 0;
                              _pageController.jumpToPage(0);
                            });
                          },
                          label: 'All',
                          isSelected: _selectedPage == 0,
                        ),
                        SizedBox(width: 1.w),
                        selectButton(
                          onTap: () {
                            setState(() {
                              _selectedPage = 1;
                              _pageController.jumpToPage(1);
                            });
                          },
                          label: 'Life',
                          isSelected: _selectedPage == 1,
                        ),
                        SizedBox(width: 1.w),
                        selectButton(
                          onTap: () {
                            setState(() {
                              _selectedPage = 2;
                              _pageController.jumpToPage(2);
                            });
                          },
                          label: 'Vehicles',
                          isSelected: _selectedPage == 2,
                        ),
                        SizedBox(width: 1.w),
                        selectButton(
                          onTap: () {
                            setState(() {
                              _selectedPage = 3;
                              _pageController.jumpToPage(3);
                            });
                          },
                          label: 'Home',
                          isSelected: _selectedPage == 3,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Expanded(
                    child: PageView(
                      physics: const BouncingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _selectedPage = index;
                        });
                      },
                      children: [
                        ListPlans(plans: plans),
                        ListPlans(plans: lifePlans),
                        ListPlans(plans: vehiclePlans),
                        ListPlans(plans: homePlans),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget selectButton({
    isSelected = false,
    required Function()? onTap,
    required String label,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.sp),
          ),
          child: Container(
            width: 25.w,
            height: 10.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.sp),
              border: Border.all(color: AppColor.tertiary, width: 1),
              color: isSelected ? AppColor.tertiary : Colors.white,
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : AppColor.tertiary,
              ),
            ),
          ),
        ),
      );
}
