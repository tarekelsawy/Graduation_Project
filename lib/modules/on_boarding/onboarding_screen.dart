import 'package:corona_test_project/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../register_login/login_screen/login_screen.dart';

class OnBoardingModel {
  String image;
  String title;
  String paragraph;
  OnBoardingModel(
      {required this.image, required this.title, required this.paragraph});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLastBoard = false;

  PageController boardController = PageController();

  List<OnBoardingModel> onBoardingItems = [
    OnBoardingModel(
        image: 'assets/images/corona-image.jpg',
        title: 'title1',
        paragraph: 'paragraph1'),
    OnBoardingModel(
      image: 'assets/images/corona-image.jpg',
      title: 'title2',
      paragraph: 'paragraph2',
    ),
    OnBoardingModel(
      image: 'assets/images/corona-image.jpg',
      title: 'title3',
      paragraph: 'paragraph3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBlack,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: colorBlack,
        actions: [
          TextButton(
            onPressed: () {
              navigateAndFinish(
                context: context,
                widget: LoginScreen(),
              );
            },
            child: const Text(
              'SKIP',
              style: TextStyle(
                color: colorYellow,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == onBoardingItems.length - 1) {
                    setState(() {
                      isLastBoard = true;
                    });
                  } else {
                    setState(() {
                      isLastBoard = false;
                    });
                  }
                },
                controller: boardController,
                itemBuilder: (context, index) {
                  return pageItem(
                    context: context,
                    model: onBoardingItems[index],
                  );
                },
                itemCount: onBoardingItems.length,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: onBoardingItems.length,
                  effect: SlideEffect(
                    activeDotColor: colorYellow,
                    dotHeight: 14,
                    dotWidth: 25,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: colorYellow,
                  onPressed: () {
                    if (isLastBoard == true) {
                      navigateAndFinish(
                          context: context, widget: LoginScreen());
                    } else {
                      boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 500,
                          ),
                          curve: Curves.easeInToLinear);
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget pageItem(
    {required BuildContext context, required OnBoardingModel model}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Expanded(
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Image(
              image: AssetImage(model.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        model.title,
        style: Theme.of(context).textTheme.headline4!.copyWith(
              color: colorYellow,
              fontFamily: 'Lobster',
            ),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        model.paragraph,
        style: const TextStyle(
          fontFamily: 'Lobster',
          color: colorYellow,
        ),
      ),
    ],
  );
}
