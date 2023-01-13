import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:jomhack/pages/calculator/calculator.dart';
import 'package:jomhack/pages/news/news.dart';
import 'package:jomhack/pages/profile/profile.dart';
import 'package:jomhack/pages/recommendation/recommendation.dart';
import 'package:sizer/sizer.dart';

import '../themes/colors.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  final PageController _pageController = PageController();
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'InsureME',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.tertiary,
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          Recommendation(),
          News(),
          Calculator(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Ionicons.home_outline), label: 'For You'),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.newspaper_outline), label: 'News'),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.calculator_outline), label: 'Calculator'),
          BottomNavigationBarItem(
              icon: Icon(Ionicons.person_outline), label: 'Profile'),
        ],
        onTap: (index) {
          setState(() {
            _pageController.jumpToPage(index);
            _selectedPage = index;
          });
        },
      ),
    );
  }
}
