import 'package:flutter/material.dart';

import 'widgets/currency_pic.dart';
import 'widgets/landing.dart';
import 'widgets/profile.dart';

class OnboardScreen extends StatelessWidget {
  OnboardScreen({super.key});
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          LandingPage(
            onGetStarted: () {
              _pageController.jumpToPage(1);
            },
          ),
          ProfileWidget(
            onGetStarted: () {
              _pageController.jumpToPage(2);
            },
          ),
          const CurrencyPicWidget()
        ],
      ),
    );
  }
}
