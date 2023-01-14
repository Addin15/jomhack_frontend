import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../themes/colors.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              'News',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.tertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
