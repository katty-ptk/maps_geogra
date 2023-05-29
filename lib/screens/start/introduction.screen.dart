import 'package:flutter/material.dart';
import 'package:maps_geogra/screens/start/intro_screens/intro_page1.dart';
import 'package:maps_geogra/screens/start/intro_screens/intro_page2.dart';
import 'package:maps_geogra/screens/start/intro_screens/intro_page3.dart';
import 'package:maps_geogra/utils/navigation.utils.dart';
import 'package:maps_geogra/utils/routes.utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _controller = PageController();
  bool _onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          // page view
          PageView(
            controller: _controller,
            onPageChanged: ( index ) {
              setState(() {
                _onLastPage = ( index == 2);
              });
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3()
            ],
          ),

          Container(
            alignment: const Alignment(0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // skip
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: const Text("skip")
                ),

                // dot indicators
                SmoothPageIndicator(
                  controller: _controller, 
                  count: 3,
                  effect: const SlideEffect(
                    spacing: 10,
                    radius: 5,
                    dotWidth: 10,
                    dotHeight: 10,
                    dotColor: Colors.white,
                    activeDotColor: Colors.black
                  ),
                ),

                // next / done
                GestureDetector(
                  onTap: () {
                    if ( _onLastPage ) {
                     NavigationUtil().navigateTo(context, Routes().HOME_SCREEN);

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: ( context ) {
                      //       return const HomePage();
                      //     }
                      //   )
                      // );
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300), 
                        curve: Curves.easeIn
                      );
                    }

                  },
                  child: Text( _onLastPage ? "finish" : "next",)
                ),
              ],
            )
          )
        ]
      ),
    );
  }
}