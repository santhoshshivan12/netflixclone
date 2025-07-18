
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Model/onboarding_entity.dart';


class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _onBoardingData = OnBoardingEntity.onBoardingData;
  int _currentPageIndex = 0;
  PageController _pageController = PageController();

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_currentPageIndex < _onBoardingData.length - 1) {
        _currentPageIndex++;
        _pageController.animateToPage(
          _currentPageIndex,
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      } else {
        _timer?.cancel(); // Stop scrolling at last page
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(
          children: [
            _pageViewBuilderWidget(),
            Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: _onBoardingData.length,
                  effect: WormEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotColor: Colors.red,
                    dotColor: Colors.grey.shade400,
                  ),
                ),
              ),
            ),

            // Constant Get Started Button
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  context.goNamed('login');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                      width: double.infinity,
                      height: 50,
                      color: Colors.red,
                      alignment: Alignment.center,
                      child: Text('Get Started', style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold)
                      )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pageViewBuilderWidget() {
    return PageView.builder(
      itemCount: _onBoardingData.length,
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
      itemBuilder: (ctx, index) {
        return Stack(
          fit: StackFit.passthrough,
          children: [
            index == 3
                ? Container(
              height: double.infinity,
              child: Image.asset(
                _onBoardingData[index].image,
                fit: BoxFit.cover,
              ),
            )
                : Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Image.asset(
                _onBoardingData[index].image,
              ),
            ),
            index == 3
                ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(.5),
                      Colors.black.withOpacity(.6),
                      Colors.black.withOpacity(.9),
                    ],
                    tileMode: TileMode.clamp,
                    begin: Alignment(0.9, 0.0),
                    end: Alignment(0.8, 0.4)),
              ),
            )
                : Container(),
            Container(
              margin: EdgeInsets.only(top: 300, left: 40, right: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _onBoardingData[index].heading,
                    style: TextStyle(fontSize: 42,fontWeight: FontWeight.bold,color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    _onBoardingData[index].description,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

}
