import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:maps_geogra/screens/start/intro_screens/intro_page1.dart';
import 'package:maps_geogra/screens/start/intro_screens/intro_page2.dart';
import 'package:maps_geogra/screens/start/intro_screens/intro_page3.dart';
import 'package:maps_geogra/utils/navigation.utils.dart';
import 'package:maps_geogra/utils/routes.utils.dart';
import 'package:maps_geogra/utils/state_manager.utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _controller = PageController();
  bool _onLastPage = false;

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
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
                      // show popup dialog
                      openDialog();
                    //  NavigationUtil().navigateTo(context, Routes().HOME_SCREEN);
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

  Widget buildUserEmail() {
    return 
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: "User Email",
            hintText: "Fill if you are USER",
            suffixIcon: GestureDetector(
              onTap: () {
                if ( _emailController.text != "" && _emailController.text.isNotEmpty && context.read<StateManager>().ROLE == Roles().USER) {
                  context.read<StateManager>().setUserEmail(_emailController.text);
                  NavigationUtil().navigateTo(context, Routes().HOME_SCREEN);  
                } else {
                  print("you need to enter an email");
                }
              },
              child: const Icon(Icons.send)
            )
          ),
        );
  }

  void openDialog() {
    showDialog(
      context: context, 
      builder: ( context ) => AlertDialog(
        
        title: const Center(child: Text("Your Role", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  context.read<StateManager>().setRole(Roles().ADMIN);

                  NavigationUtil().navigateTo(context, Routes().HOME_SCREEN);
                }, 
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black87)
                ),
                child: const Text(
                  "Admin",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  context.read<StateManager>().setRole(Roles().USER);
                }, 
                style: ButtonStyle(
                  // backgroundColor: const MaterialStatePropertyAll(Colors.black87),
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.redAccent;
                      } //<-- SEE HERE
                      return Colors.green; // Defer to the widget's default.
                    },
                  ),
                ),
                child: const Text(
                  "User",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
            ),

            buildUserEmail()
          ],
        ),
      )
    );
  }

}